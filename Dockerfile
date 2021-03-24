FROM debian:bullseye-slim

LABEL authors="Simon Heumos, Jean Monlong"
LABEL description="Preliminary docker image containing all requirements for pgge pipeline"
LABEL base_image="debian:bullseye-slim"
LABEL software="pgge"
LABEL about.home="https://github.com/pangenome/pgge"
LABEL about.license="SPDX:MIT"

# Required dependencies
# samtools
# TODO add samtools from Bioconda?
RUN apt-get update \
        && apt-get install -y --no-install-recommends \
        wget \
        curl \
        less \
        gcc \ 
        samtools \
        tzdata \
        make \
        git \
        sudo \
        pkg-config \
        bc \
        time \
        procps \
        libxml2-dev libssl-dev libcurl4-openssl-dev \ 
        apt-transport-https software-properties-common dirmngr gpg-agent \ 
        && rm -rf /var/lib/apt/lists/*

# rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -o rust.sh && \
	sh rust.sh -y --no-modify-path

ENV PATH /root/.cargo/bin:$PATH

RUN cd ../../
# peanut
RUN git clone https://github.com/pangenome/rs-peanut.git \
    && cd rs-peanut \
	&& git pull \
    && git checkout 2783bca \
	&& cargo build --release \
    && cp target/release/peanut /usr/local/bin/peanut \
    && cd ../

# splitfa
RUN git clone https://github.com/ekg/splitfa.git \
    && cd splitfa \
    && git pull \
    && git checkout 98589b2 \
	&& cargo build --release \
    && cp target/release/splitfa /usr/local/bin/splitfa \
    && cd ../

# miniconda3
RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && bash Miniconda3-latest-Linux-x86_64.sh -b -p /miniconda \
    && rm -f Miniconda3-latest-Linux-x86_64.sh 
ENV PATH /miniconda/bin:$PATH
SHELL ["/bin/bash", "-c"]

# GraphAligner
# Unfortunately, the current Bioconda version of GraphAligner emits a 15-column GAF, whereas the most recent commit on github emits a 16-column GAF
# Therefore, we can't use the Bioconda version as of now
RUN git clone --recursive https://github.com/maickrau/GraphAligner \
        && cd GraphAligner \
        && git pull \
        && git checkout 48143da \
        && git submodule update --init --recursive \
        && conda env create -f CondaEnvironment.yml \ 
        && source activate GraphAligner \
        && make bin/GraphAligner \
        && cp bin/GraphAligner /usr/local/bin/GraphAligner \
        && cd ../ \
        && exit

# Install the conda environment
COPY environment.yml /
RUN conda env create --quiet -f /environment.yml && conda clean -a

# Add conda installation dir to PATH (instead of doing 'conda activate')
ENV PATH /miniconda/envs/pgge-dev/bin:$PATH

# Set path for all users
RUN echo "export PATH=$PATH" > /etc/profile

# bring in the binaries and scripts from pgge
COPY pgge /usr/local/bin/pgge
RUN mkdir /scripts
COPY scripts/beehave.R /scripts/beehave.R
RUN chmod 777 /usr/local/bin/pgge && chmod 777 /scripts/beehave.R

ENTRYPOINT [ "/bin/bash", "-l", "-c" ]