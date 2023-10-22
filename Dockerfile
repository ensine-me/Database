FROM postgres:latest

ENV POSTGRES_ROOT_PASSWORD=Ensine_1234
ENV POSTGRES_DATABASE=ensineme
ENV POSTGRES_USER=ensine_admin
ENV POSTGRES_PASSWORD=Ensine_1234

COPY banco.sql /docker-entrypoint-initdb.d/

EXPOSE 5432
