# 🆘 RescueMesh Platform - Complete System

**Full-Stack Disaster Response Coordination Platform**

A production-ready, microservices-based emergency response system with modern React frontend that connects victims, volunteers, and authorities during disasters.

---

## ⚡ Quick Start (One Command)

```bash
docker compose up -d --build
```

**Then access:**
- 🌐 **Frontend**: http://localhost:3000
- 🔌 **API Gateway**: http://localhost:8000

**That's it!** The entire system (frontend + 6 backend services + infrastructure) is now running.

---

## 🎯 What's Included

### Frontend Application
✅ **Modern React UI** (http://localhost:3000)
- 📊 Real-time disaster dashboard
- 🆘 Emergency SOS request system  
- 🗺️ Interactive disaster map (Leaflet)
- 👥 Volunteer hub & matching
- 📦 Resource & skill management
- 🔔 Notification center
- 👤 User profile management

### Backend Microservices
✅ **6 Independent Services** (Ports 3001-3006)

1. **User Service** (Go) - User profiles & location tracking
2. **Skill Service** (Go) - Skills & resources registry
3. **Disaster Service** (Python) - Disaster event management
4. **SOS Service** (Node.js) - Emergency request handling
5. **Matching Service** (Node.js) - Volunteer-victim matching
6. **Notification Service** (Node.js) - Multi-channel alerts

### Infrastructure
✅ **Complete Stack**
- 6x PostgreSQL databases
- 6x Redis caches
- 1x RabbitMQ message queue
- 1x Nginx API Gateway
- 1x Nginx frontend server

**Total: 17 Docker containers** working together seamlessly

---

## 🏗️ System Architecture

```
┌──────────────────────────────────────────────────────────────┐
│              Frontend (React + Tailwind)                     │
│                 http://localhost:3000                        │
│   Dashboard | SOS | Map | Volunteers | Resources | Profile  │
└───────────────────────────┬──────────────────────────────────┘
                            │
                            ▼
┌──────────────────────────────────────────────────────────────┐
│                   API Gateway (Nginx)                        │
│                  http://localhost:8000                       │
│              Unified Entry Point for All APIs                │
└──┬──────┬───────┬────────┬─────────┬──────────┬─────────────┘
   │      │       │        │         │          │
   ▼      ▼       ▼        ▼         ▼          ▼
┌─────┬────────┬───────┬────────┬─────────┬──────────────────┐
│User │ Skill  │Disaster│  SOS   │Matching │  Notification   │
│:3001│ :3002  │ :3003  │ :3004  │ :3005   │    :3006       │
│ Go  │  Go    │ Python │Node.js │Node.js  │   Node.js      │
└──┬──┴───┬────┴────┬───┴───┬────┴────┬────┴────┬───────────┘
   │      │         │       │         │         │
   ▼      ▼         ▼       ▼         ▼         ▼
┌─────────────────────────────────────────────────────────────┐
│           PostgreSQL Databases (6 instances)                │
│  users | skills | disasters | sos | matching | notification│
└───────────────────┬─────────────────────────────────────────┘
                    │
                    ▼
┌─────────────────────────────────────────────────────────────┐
│              Redis Caches (6 instances)                     │
└───────────────────┬─────────────────────────────────────────┘
                    │
                    ▼
┌─────────────────────────────────────────────────────────────┐
│                  RabbitMQ Message Queue                     │
│               (Inter-service messaging)                     │
└─────────────────────────────────────────────────────────────┘
```

---

## 📋 Features

### 🏠 Dashboard
- Active disaster overview
- Real-time SOS request monitoring
- Volunteer statistics
- Affected population tracking
- Quick action buttons

### 🆘 Emergency SOS
- One-click emergency request
- Urgency level selection (Critical/High/Medium/Low)
- Disaster-specific skill/resource matching
- GPS location tracking
- Multi-language support ready
- Request history tracking

### 🗺️ Interactive Disaster Map
- Real-time disaster visualization
- Color-coded severity zones
- SOS request markers
- Volunteer location display
- Impact radius circles
- Click-for-details popups
- OpenStreetMap integration

### 👥 Volunteer Hub
- Browse available SOS requests
- Accept/reject match assignments
- Skill & certification management
- Trust score tracking
- Response history
- Real-time matching notifications

### 📦 Resource Management
- Register skills (medical, rescue, etc.)
- Register resources (boats, equipment, etc.)
- Availability status control
- Certification levels
- Disaster-specific templates

### 🔔 Notifications
- Real-time alerts
- SOS notifications
- Match assignments
- Disaster updates
- Multi-channel (SMS, Email, Push)
- Read/unread status

### 👤 User Profile
- Personal information management
- Location tracking
- Trust score display
- Role selection (Volunteer/Victim/Authority/NGO)
- Activity history

---

## 🎮 Using the System

### 1️⃣ First Time Setup
```bash
# Clone the repository
git clone <repository-url>
cd rescuemesh

# Start everything
docker compose up -d --build

# Wait for services to be healthy (~30 seconds)
docker compose ps

# Open the application
open http://localhost:3000
```

### 2️⃣ Send an SOS Request
1. Navigate to **SOS Emergency** (sidebar)
2. Select an active disaster
3. Choose urgency level
4. Describe your situation
5. Select required skills/resources
6. Click **SEND SOS REQUEST**
7. Help is automatically dispatched!

### 3️⃣ Volunteer to Help
1. Go to **Volunteer Hub**
2. View **Available Requests**
3. Click **Respond** on any request
4. System matches you based on:
   - Your location proximity
   - Your registered skills
   - Your availability
   - Your trust score

### 4️⃣ View Disasters on Map
1. Click **Disaster Map** in sidebar
2. See all active disasters with color-coded severity
3. Click markers for details
4. View SOS requests in affected areas

---

## 🔧 Management Commands

### View Logs
```bash
# All services
docker compose logs -f

# Specific service
docker compose logs -f frontend
docker compose logs -f user-service
docker compose logs -f sos-service
```

### Health Checks
```bash
# Frontend
curl http://localhost:3000/health

# API Gateway
curl http://localhost:8000/health

# Individual services
curl http://localhost:3001/health  # User
curl http://localhost:3002/health  # Skill
curl http://localhost:3003/health  # Disaster
curl http://localhost:3004/health  # SOS
curl http://localhost:3005/health  # Matching
curl http://localhost:3006/health  # Notification
```

### Restart Services
```bash
# Restart all
docker compose restart

# Restart specific
docker compose restart frontend
docker compose restart user-service
```

### Stop Everything
```bash
# Stop but keep data
docker compose down

# Stop and remove all data
docker compose down -v
```

### Rebuild After Changes
```bash
# Rebuild all
docker compose up -d --build

# Rebuild specific service
docker compose up -d --build frontend
```

---

## 📊 Port Reference

| Service | Port | URL |
|---------|------|-----|
| Frontend | 3000 | http://localhost:3000 |
| User Service | 3001 | http://localhost:3001 |
| Skill Service | 3002 | http://localhost:3002 |
| Disaster Service | 3003 | http://localhost:3003 |
| SOS Service | 3004 | http://localhost:3004 |
| Matching Service | 3005 | http://localhost:3005 |
| Notification Service | 3006 | http://localhost:3006 |
| API Gateway | 8000 | http://localhost:8000 |
| RabbitMQ Management | 15672 | http://localhost:15672 |
| PostgreSQL (Users) | 5431 | localhost:5431 |
| PostgreSQL (Skills) | 5432 | localhost:5432 |
| PostgreSQL (Disasters) | 5433 | localhost:5433 |
| PostgreSQL (SOS) | 5434 | localhost:5434 |
| PostgreSQL (Matching) | 5435 | localhost:5435 |
| PostgreSQL (Notifications) | 5436 | localhost:5436 |

---

## 🛠️ Technology Stack

### Frontend
- **React 18** - UI framework
- **Tailwind CSS** - Styling
- **Vite** - Build tool
- **React Router** - Navigation
- **Leaflet** - Interactive maps
- **Axios** - API client
- **React Hot Toast** - Notifications

### Backend Services
- **Go (Gin)** - User & Skill services
- **Python (FastAPI)** - Disaster service
- **Node.js (Express)** - SOS, Matching, Notification services

### Infrastructure
- **PostgreSQL 15** - Databases
- **Redis 7** - Caching
- **RabbitMQ 3** - Message queue
- **Nginx** - API Gateway & Frontend server
- **Docker & Docker Compose** - Containerization

---

## 📚 Documentation

- **[STARTUP_GUIDE.md](./STARTUP_GUIDE.md)** - Detailed startup instructions
- **[FRONTEND_SUMMARY.md](./FRONTEND_SUMMARY.md)** - Frontend implementation details
- **[frontend/README.md](./frontend/README.md)** - Frontend-specific documentation
- **Service READMEs**: Each service has its own README in its directory

---

## 🎨 Disaster Types Supported

| Type | Icon | Severity Levels |
|------|------|----------------|
| Flood | 🌊 | Low → Critical |
| Earthquake | 🌋 | Low → Critical |
| Fire | 🔥 | Low → Critical |
| Tsunami | 🌊 | Low → Critical |
| Cyclone | 🌪 | Low → Critical |
| Landslide | ⛰ | Low → Critical |

---

## 🔐 Default Credentials

**RabbitMQ Management UI** (http://localhost:15672)
- Username: `admin`
- Password: `admin`

**PostgreSQL Databases**
- Username: `postgres`
- Password: `postgres`

⚠️ **Change these in production!**

---

## 🐛 Troubleshooting

### Frontend not loading?
```bash
docker compose logs frontend
docker compose restart frontend
```

### API errors?
```bash
# Check if API gateway is running
docker compose ps api-gateway

# Check backend services
docker compose ps | grep service

# Restart gateway
docker compose restart api-gateway
```

### Database connection errors?
```bash
# Check PostgreSQL containers
docker compose ps | grep postgres

# View logs
docker compose logs postgres-users
```

### Port conflicts?
```bash
# Check what's using the ports
lsof -i :3000  # Frontend
lsof -i :8000  # API Gateway

# Stop conflicting services or change ports in docker-compose.yml
```

---

## 🚀 Development

### Local Development (without Docker)
```bash
# Start infrastructure only
docker compose up -d postgres-users redis-users rabbitmq

# Run services individually
cd rescuemesh-user-service && go run main.go
cd rescuemesh-skill-service && go run main.go
cd rescuemesh-disaster-service && python main.py
cd rescuemesh-sos-service && npm start
cd rescuemesh-matching-service && npm start
cd rescuemesh-notification-service && npm start

# Run frontend in dev mode
cd frontend && npm run dev
```

### Adding New Features
1. Update backend service APIs
2. Add API methods to `frontend/src/services/index.js`
3. Create/update React components
4. Add routes if needed
5. Test locally
6. Build and deploy with Docker

---

## 📈 Sample Data

The system includes sample data for testing:
- 3 pre-configured disasters (Flood in Delhi, Earthquake, Cyclone)
- Sample users (user-001, user-002, etc.)
- Test skills and resources
- Mock SOS requests

---

## ✅ Success Checklist

After running `docker compose up -d --build`, verify:

- [ ] All 17 containers are running (`docker compose ps`)
- [ ] Frontend accessible at http://localhost:3000
- [ ] API Gateway responding at http://localhost:8000
- [ ] Can view Dashboard with statistics
- [ ] Can see disasters on Map
- [ ] Can send SOS request
- [ ] Can register as volunteer
- [ ] Notifications are working
- [ ] No errors in logs (`docker compose logs`)

---

## 🎯 Use Cases

1. **Natural Disaster Response**
   - Flood victims request boats
   - Earthquake survivors need medical help
   - Fire evacuations require shelter

2. **Volunteer Coordination**
   - Medical professionals offer services
   - Boat operators assist in floods
   - Engineers assess structural damage

3. **Resource Allocation**
   - Track available ambulances
   - Manage food and water supplies
   - Coordinate rescue equipment

4. **Authority Oversight**
   - Monitor all active disasters
   - Track response effectiveness
   - Coordinate between agencies

---

## 🤝 Contributing

Contributions welcome! Please:
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

---

## 📄 License

This project is part of a disaster response initiative.

---

## 🙏 Acknowledgments

Built with modern technologies to help save lives during emergencies.

**Tech Stack**: React, Go, Python, Node.js, PostgreSQL, Redis, RabbitMQ, Docker, Nginx, Tailwind CSS, Leaflet

---

## 📞 Support

For issues or questions:
1. Check the [STARTUP_GUIDE.md](./STARTUP_GUIDE.md)
2. Review service-specific READMEs
3. Check logs: `docker compose logs [service-name]`
4. Verify all containers are healthy: `docker compose ps`

---

## 🎉 Quick Links

- 🌐 **Frontend**: http://localhost:3000
- 🔌 **API Gateway**: http://localhost:8000  
- 📊 **RabbitMQ**: http://localhost:15672 (admin/admin)
- 📚 **Full Documentation**: [STARTUP_GUIDE.md](./STARTUP_GUIDE.md)

---

**Made with ❤️ for Emergency Response** 🆘

*"In disasters, every second counts. RescueMesh coordinates the right help, at the right place, at the right time."*
