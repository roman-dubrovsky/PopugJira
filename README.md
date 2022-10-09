# PopugJira

Homework project for [asynchronous architecture cources](https://education.borshev.com/architecture) .

Homework 1: https://github.com/roman-dubrovsky/PopugJira/pull/1


UI for checking kafka messages:

```
docker run --network=host \
  -e KAFKA_BROKERS=localhost:9092 \
  docker.redpanda.com/vectorized/console:latest
```