# Technology-stack logos

Drop one **PNG** per technology here. They are pulled into the technology-stack
table in `mainmatter/part2/chapter5/chapter5.tex` (`tab:ch5-stack`) by the
`\techlogo{filename}` macro (defined in `config/commands.tex`).

The macro is **graceful**: if a file is missing it renders a small grey text
stub instead, so a missing logo never breaks the build — but the final PDF
should have every logo present.

Use the official brand logo, square-ish or horizontal, on a transparent
background, ideally ≥ 200 px tall. Expected filenames (all `.png`):

| Filename | Technology |
|---|---|
| `python.png` | Python |
| `sql.png` | SQL |
| `postgresql.png` | PostgreSQL |
| `dagster.png` | Dagster |
| `django.png` | Django |
| `drf.png` | Django REST Framework |
| `celery.png` | Celery |
| `redis.png` | Redis |
| `nextjs.png` | Next.js |
| `react.png` | React |
| `tailwind.png` | Tailwind CSS |
| `echarts.png` | Apache ECharts |
| `d3.png` | D3.js |
| `leaflet.png` | Leaflet |
| `tremor.png` | Tremor |
| `fastapi.png` | FastAPI |
| `faker.png` | Faker |
| `docker.png` | Docker |
| `docker-compose.png` | Docker Compose |
| `nginx.png` | Nginx |
| `letsencrypt.png` | Let's Encrypt |
| `git.png` | Git |
| `vscode.png` | Visual Studio Code |
