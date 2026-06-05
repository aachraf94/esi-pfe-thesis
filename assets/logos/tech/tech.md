# LOGIQ — Technology Stack

A Business Intelligence platform for Yalidine El Djazair Service (logistics). The project is a monorepo composed of a data warehouse, an ETL pipeline, a backend API, a frontend dashboard, and a mock data-source simulator.

| Technology | Used Part | Purpose |
|---|---|---|

| **Python** | ETL / Backend / Mock | Primary backend & ETL programming language language |

| **PostgreSQL** | Warehouse / Platform DB / Mock DB | Data warehouse (Snowflake schema), Django platform database, and the mock source-systems database |
| **SQL** | Warehouse | Dimensions, facts, staging, aggregates, init/validate scripts |

| **Dagster** | ETL | Orchestration of the ETL pipeline (assets, schedules, resources) |

| **Django (≥4.2)** | Backend | Web framework / API foundation |
| **Django REST Framework** | Backend | REST API endpoints |

| **Celery** | Backend | Asynchronous & scheduled tasks |
| **Redis 7** | Backend | Celery broker / cache |

| **Next.js** | Frontend | React framework |
| **Reactjs** | Frontend | UI library |
| **Tailwind CSS 3** | Frontend | Utility-first styling |
| **ECharts** | Frontend | Charts & data visualization |

| **FastAPI** | Mock Datasources | backend app to simulate 5 Yalidine source systems (17 endpoints) |
| **Faker** | Mock Datasources | Synthetic data generation |

| **Docker** | Infrastructure | Containerization |
| **Docker Compose** | Infrastructure | Containers orchestration |
| **Git** | Infrastructure | Version control |

| **vscode** | Development | Code editor |
