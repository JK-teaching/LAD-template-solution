# LA Dashboards course example solution
[![Lifecycle: mature](https://img.shields.io/badge/lifecycle-mature-green.svg)](https://www.tidyverse.org/lifecycle/#mature)

This repository contains the example solution for the course "LA Dashboards" taught in WS 2021 at Humboldt-Universität zu Berlin. It contains two docker images:
* `mariadb` - containing OULAD dataset as a database
* `oulad.dashboard` - R Shiny golem web dashboard connecting to the `mariadb`

The basic configuration is contained in `docker-compose.yml`. 

To run example execute:
``` {bash}
docker-compose up
```
in the project folder.