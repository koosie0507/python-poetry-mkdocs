ARG PYTHON_VERSION

FROM python:${PYTHON_VERSION}

ARG POETRY_VERSION
ARG MKDOCS_VERSION
ARG MKDOCS_BUILD_PLANTUML_VERSION
ARG PLANTUML_VERSION

RUN apt-get update -yq \
&& apt-get install -yq openjdk-17-jre-headless \
&& rm -rf /var/lib/apt/lists/*

RUN curl -sSL --verbose "https://install.python-poetry.org" | POETRY_HOME=/opt/poetry python3 - \
&& pip install "mkdocs==${MKDOCS_VERSION}" "mkdocs-build-plantuml-plugin==${MKDOCS_BUILD_PLANTUML_VERSION}"

RUN mkdir -p /opt/plantuml/{bin,lib} \
&& echo "https://github.com/plantuml/plantuml/releases/download/v${PLANTUML_VERSION}/plantuml-${PLANTUML_VERSION}.jar" > abc.txt \
&& curl -L "https://github.com/plantuml/plantuml/releases/download/v${PLANTUML_VERSION}/plantuml-${PLANTUML_VERSION}.jar" --create-dirs --output "/opt/plantuml/lib/plantuml.jar"

COPY plantuml.sh /opt/plantuml/bin/plantuml
RUN chmod 0755 /opt/plantuml/bin/plantuml

ENV PATH="/opt/poetry/bin:/opt/plantuml/bin:${PATH}"

ENTRYPOINT [ "/bin/sh" ]
