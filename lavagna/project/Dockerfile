FROM maven:3.6.1-jdk-8-alpine AS builder

WORKDIR /lavagna

COPY .  .

RUN apk add openssl fontconfig ttf-dejavu ca-certificates

RUN mvn verify

########################

FROM openjdk:8-jre-alpine

WORKDIR /lava

COPY --from=builder /lavagna/target/*.war ./

COPY ./java_exec.sh /lava

ENV DB_DIALECT 'MYSQL'
ENV DB_URL 'jdbc:mysql://db:3306/lavagna'
ENV DB_USER 'root'
ENV DB_PASS '123'
ENV SPRING_PROFILE 'dev'

EXPOSE 8080

RUN chmod 775 java_exec.sh

# Execute the web archive
ENTRYPOINT [ "./java_exec.sh" ]
