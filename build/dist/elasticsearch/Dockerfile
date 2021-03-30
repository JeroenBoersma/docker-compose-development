ARG FROM_IMAGE=elasticsearch
ARG FROM_TAG=7.4.2

FROM ${FROM_IMAGE}:${FROM_TAG}
RUN cd /usr/share/elasticsearch \
    && bin/elasticsearch-plugin install analysis-phonetic \
    && bin/elasticsearch-plugin install analysis-icu
