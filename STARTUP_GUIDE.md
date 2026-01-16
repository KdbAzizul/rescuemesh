# RescueMesh - Complete System Startup Guide

## 🚀 Quick Start (One Command)

From the project root directory, run:

```bash
docker compose up -d --build
```

This will start:
- ✅ 6 PostgreSQL databases
- ✅ 6 Redis instances
- ✅ RabbitMQ message queue
- ✅ 6 Microservices (User, Skill, Disaster, SOS, Matching, Notification)
- ✅ API Gateway (Nginx)
- ✅ Frontend (React + Nginx)

## 📡 Access Points

### Frontend Application
**http://localhost:3000**
- Modern React-based UI
- Real-time disaster map
- SOS emergency system
- Volunteer hub
- Resource management

### API Gateway
**http://localhost:8000**
- Unified API endpoint for all services

### Individual Services
- User Service: http://localhost:3001
- Skill Service: http://localhost:3002
- Disaster Service: http://localhost:3003
- SOS Service: http://localhost:3004
- Matching Service: http://localhost:3005
- Notification Service: http://localhost:3006

### Infrastructure
- RabbitMQ Management: http://localhost:15672 (admin/admin)

## 🏗️ Architecture Overview

```
┌─────────────────────────────────────────────────────────┐
│                    Frontend (React)                     │
│                   http://localhost:3000                 │
└────────────────────────┬────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────┐
│                  API Gateway (Nginx)                    │
│                   http://localhost:8000                 │
└────┬──────┬──────┬──────┬──────┬──────┬────────────────┘
     │      │      │      │      │      │
     ▼      ▼      ▼      ▼      ▼      ▼
┌────────┬──────┬───────┬─────┬─────────┬──────────────┐
│ User   │Skill │Disaster│SOS │Matching │Notification │
│Service │Service│Service│Svc │Service  │Service      │
│:3001   │:3002 │:3003  │:3004│:3005    │:3006        │
└────┬───┴───┬──┴────┬──┴──┬──┴────┬────┴────┬─────────┘
     │       │       │     │       │         │
     ▼       ▼       ▼     ▼       ▼         ▼
┌──────────────────────────────────────────────────────┐
│         PostgreSQL Databases (6 instances)           │
└──────────────────────────────────────────────────────┘
     │       │       │     │       │         │
     ▼       ▼       ▼     ▼       ▼         ▼
┌──────────────────────────────────────────────────────┐
│            Redis Caches (6 instances)                │
└──────────────────────────────────────────────────────┘
                         │
                         ▼
┌──────────────────────────────────────────────────────┐
│                    RabbitMQ                          │
│                 Message Queue                        │
└──────────────────────────────────────────────────────┘
```

## 🎯 System Features

### Frontend Features
1. **Dashboard** - Overview of disasters, SOS requests, and statistics
2. **SOS Emergency** - Send emergency requests with location and requirements
3. **Disaster Map** - Interactive map showing disasters and SOS locations
4. **Volunteer Hub** - Respond to emergencies and manage matches
5. **Resource Management** - Register skills and resources
6. **Notifications** - Real-time alerts and messages
7. **Profile** - User information and trust score

### Backend Services
1. **User Service (Go)** - User profiles and location tracking
2. **Skill Service (Go)** - Skills and resources registry
3. **Disaster Service (Python)** - Disaster event management
4. **SOS Service (Node.js)** - Emergency request handling
5. **Matching Service (Node.js)** - Volunteer-victim matching
6. **Notification Service (Node.js)** - Multi-channel notifications

## 📋 Usage Examples

### 1. View Active Disasters
1. Open http://localhost:3000
2. Click "Disaster Map" in sidebar
3. View disasters with color-coded severity
4. Click markers for details

### 2. Send SOS Request
1. Click "SOS Emergency" in sidebar
2. Select active disaster
3. Choose urgency level (Critical/High/Medium/Low)
4. Describe situation
5. Select required skills/resources
6. Click "SEND SOS REQUEST"

### 3. Volunteer to Help
1. Click "Volunteer Hub"
2. View "Available Requests" tab
3. Click "Respond" on any request
4. Confirm your response
5. Check "My Matches" tab for assignments

### 4. Register Skills/Resources
1. Click "Resources" in sidebar
2. Click "Add New"
3. Choose Resource or Skill
4. Fill in details
5. Set availability status

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

### Restart Services
```bash
# Restart all
docker compose restart

# Restart specific service
docker compose restart frontend
docker compose restart api-gateway
```

### Stop All Services
```bash
docker compose down
```

### Stop and Remove Volumes (Clean Reset)
```bash
docker compose down -v
```

### Rebuild Specific Service
```bash
docker compose up -d --build frontend
docker compose up -d --build user-service
```

### Check Service Status
```bash
docker compose ps
```

## 🔍 Health Checks

### Frontend
```bash
curl http://localhost:3000/health
```

### API Gateway
```bash
curl http://localhost:8000/api/users/health
```

### Individual Services
```bash
# User Service
curl http://localhost:3001/health

# Skill Service
curl http://localhost:3002/health

# Disaster Service
curl http://localhost:3003/health

# SOS Service
curl http://localhost:3004/health

# Matching Service
curl http://localhost:3005/health

# Notification Service
curl http://localhost:3006/health
```

## 🐛 Troubleshooting

### Frontend not loading
```bash
# Check if container is running
docker compose ps frontend

# Check logs
docker compose logs frontend

# Rebuild
docker compose up -d --build frontend
```

### API errors in frontend
1. Verify API gateway is running: `docker compose ps api-gateway`
2. Check backend services are healthy
3. Verify network connectivity: `docker network inspect rescuemesh-network`

### Database connection errors
```bash
# Check PostgreSQL containers
docker compose ps | grep postgres

# View database logs
docker compose logs postgres-users
docker compose logs postgres-skills
```

### Services not starting
```bash
# Check for port conflicts
lsof -i :3000  # Frontend
lsof -i :8000  # API Gateway
lsof -i :3001-3006  # Backend services

# Remove and restart
docker compose down
docker compose up -d
```

## 🔐 Security Notes

⚠️ **This is a development setup. For production:**
- Change all default passwords
- Add SSL/TLS certificates
- Implement proper authentication
- Add rate limiting
- Configure CORS properly
- Use environment-specific configurations
- Enable database encryption
- Add API key authentication

## 📊 Sample Data

The system comes with sample data:
- 3 pre-configured disasters
- Sample users (user-001, user-002, etc.)
- Test skills and resources
- Mock SOS requests

## 🎨 Customization

### Frontend Styling
- Edit `frontend/tailwind.config.js` for colors
- Modify `frontend/src/index.css` for global styles
- Update components in `frontend/src/components/`

### API Configuration
- Environment variables in `docker-compose.yml`
- Service ports can be changed
- Database credentials configurable

## 📝 Development Workflow

### Local Development (without Docker)
```bash
# Terminal 1 - Start infrastructure
docker compose up -d postgres-users redis-users rabbitmq

# Terminal 2 - Start backend services
cd rescuemesh-user-service && go run main.go
cd rescuemesh-skill-service && go run main.go
cd rescuemesh-disaster-service && python main.py
# ... etc

# Terminal 3 - Start frontend
cd frontend && npm run dev
```

### With Docker (Recommended)
```bash
docker compose up -d --build
```

## 🚦 Production Deployment

For production deployment:
1. Build optimized images
2. Use docker-compose.prod.yml
3. Configure environment variables
4. Set up reverse proxy (Caddy/Nginx)
5. Enable HTTPS
6. Configure monitoring (Prometheus/Grafana)
7. Set up logging aggregation
8. Configure backups for databases

## 📞 Support

For issues:
1. Check logs: `docker compose logs [service-name]`
2. Verify all containers are running: `docker compose ps`
3. Review this guide
4. Check individual service READMEs

## 🎉 Success Checklist

After running `docker compose up -d --build`:

- [ ] All containers are running (17 containers)
- [ ] Frontend accessible at http://localhost:3000
- [ ] API Gateway responding at http://localhost:8000
- [ ] Can view disaster map
- [ ] Can send SOS request
- [ ] Can register as volunteer
- [ ] Notifications working
- [ ] No errors in logs

## 🏁 Next Steps

1. Explore the dashboard
2. Try sending an SOS request
3. Register your skills
4. View the disaster map
5. Respond to emergencies as volunteer
6. Check notifications

**The entire RescueMesh platform is now running!** 🎊
