FROM schemacrawler/schemacrawler:v15.03.04

USER schcrwlr
WORKDIR /home/schcrwlr

USER root

RUN apk --no-cache add curl

# Copy additional plugins
COPY plugins/*.jar /opt/schemacrawler/lib/

RUN curl https://jitpack.io/com/github/adriens/schemacrawler-additional-command-lints-as-csv/1.5/schemacrawler-additional-command-lints-as-csv-1.5.jar --output /opt/schemacrawler/lib/schemacrawler-additional-command-lints-as-csv-1.5.jar

RUN chmod +rx /opt/schemacrawler/lib/*.jar

# Create aliases for SchemaCrawler
RUN chmod +rx /opt/schemacrawler/schemacrawler.sh
USER schcrwlr
RUN echo 'alias schemacrawler="/opt/schemacrawler/schemacrawler.sh"' >> /home/schcrwlr/.bashrc