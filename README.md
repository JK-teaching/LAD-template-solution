## LA Dashboards course example solution
[![Lifecycle: mature](https://img.shields.io/badge/lifecycle-mature-green.svg)](https://www.tidyverse.org/lifecycle/#mature)

This repository contains the example solution for the course "Learning Analytics" taught at Humboldt-Universität zu Berlin. It contains two docker images:
* `mariadb` - containing OULAD dataset as a database
* `oulad.dashboard` - R Shiny golem web dashboard connecting to the `mariadb`

The basic configuration is contained in `docker-compose.yml`. 

To run example execute:
``` {bash}
docker-compose up
```
in the project folder. Be patient - shiny container takes time to build and the mariadb database is "huge" so the initial insert takes time too. 

## Requirements
Docker Engine: 20.10.7 or higher

Docker Compose: 1.29.2 or higher

> You need to have `docker` daemon up and running to run this example.
