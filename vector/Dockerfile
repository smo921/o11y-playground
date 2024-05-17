FROM timberio/vector:0.37.1-debian

COPY vector/entrypoint.sh /custom_entrypoint.sh
COPY vector/vector.yaml /etc/vector/vector.yaml

ENTRYPOINT [ "/custom_entrypoint.sh" ]
