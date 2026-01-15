# RescueMesh Setup Guide

## 🚀 Quick Start

### Prerequisites
- Docker & Docker Compose installed
- Node.js 18+ (for local development)
- Git

### Step 1: Clone and Setup

```bash
# Navigate to project directory
cd rescuemesh

# Copy environment file (optional, for production)
cp .env.example .env
# Edit .env with your Twilio/Firebase credentials if needed
```

### Step 2: Start All Services

```bash
# Build and start all services
docker-compose up --build

# Or run in detached mode
docker-compose up -d --build
```

### Step 3: Verify Services

Check service health:
```bash
# SOS Service
curl http://localhost:3004/health

# Matching Service
curl http://localhost:3005/health

# Notification Service
curl http://localhost:3006/health

# API Gateway
curl http://localhost:8000/health
```

### Step 4: Access Services

- **API Gateway**: http://localhost:8000
- **SOS Service**: http://localhost:3004
- **Matching Service**: http://localhost:3005
- **Notification Service**: http://localhost:3006
- **RabbitMQ Management**: http://localhost:15672 (admin/admin)

---

## 🧪 Testing the Services

### 1. Create an SOS Request

```bash
curl -X POST http://localhost:8000/api/sos/requests \
  -H "Content-Type: application/json" \
  -d '{
    "disasterId": "disaster-123",
    "requestedBy": "user-456",
    "requiredSkills": ["boat_operator", "medic"],
    "requiredResources": ["boat"],
    "urgency": "critical",
    "numberOfPeople": 10,
    "location": {
      "latitude": 28.6139,
      "longitude": 77.2090
    },
    "description": "Family trapped in flooded building",
    "contactPhone": "+1234567890"
  }'
```

### 2. Trigger Matching

```bash
curl -X POST http://localhost:8000/api/matching/match \
  -H "Content-Type: application/json" \
  -d '{
    "requestId": "sos-123",
    "disasterId": "disaster-123",
    "disasterType": "flood",
    "requiredSkills": ["boat_operator", "medic"],
    "requiredResources": ["boat"],
    "location": {
      "latitude": 28.6139,
      "longitude": 77.2090
    },
    "urgency": "critical",
    "radius": 10
  }'
```

### 3. Send Notification

```bash
curl -X POST http://localhost:8000/api/notifications/send \
  -H "Content-Type: application/json" \
  -d '{
    "recipientId": "user-789",
    "recipientPhone": "+1234567890",
    "channels": ["sms", "push"],
    "type": "sos_match",
    "priority": "high",
    "data": {
      "requestId": "sos-123",
      "message": "You have been matched to an emergency request"
    }
  }'
```

---

## 🔧 Local Development

### Running Services Individually

```bash
# SOS Service
cd rescuemesh-sos-service
npm install
npm run dev

# Matching Service
cd rescuemesh-matching-service
npm install
npm run dev

# Notification Service
cd rescuemesh-notification-service
npm install
npm run dev
```

### Environment Variables

Each service has its own `.env.example` file. Copy to `.env` and configure:

```bash
# In each service directory
cp .env.example .env
```

---

## 🐳 Docker Commands

```bash
# Start services
docker-compose up

# Start in background
docker-compose up -d

# Stop services
docker-compose down

# Stop and remove volumes
docker-compose down -v

# View logs
docker-compose logs -f sos-service
docker-compose logs -f matching-service
docker-compose logs -f notification-service

# Rebuild a specific service
docker-compose build sos-service
docker-compose up -d sos-service

# Check service status
docker-compose ps
```

---

## 🔍 Troubleshooting

### Services Not Starting

1. **Check Docker is running**
   ```bash
   docker ps
   ```

2. **Check port conflicts**
   - Ensure ports 3004, 3005, 3006, 8000, 5434-5436, 6374-6376, 5672, 15672 are available

3. **Check logs**
   ```bash
   docker-compose logs
   ```

### Database Connection Issues

1. **Wait for databases to be healthy**
   ```bash
   docker-compose ps
   # Wait until all databases show "healthy"
   ```

2. **Check database logs**
   ```bash
   docker-compose logs postgres-sos
   ```

### Message Queue Issues

1. **Check RabbitMQ is running**
   ```bash
   curl http://localhost:15672
   # Login: admin/admin
   ```

2. **Check queues**
   - Visit http://localhost:15672
   - Navigate to "Queues" tab

---

## 📊 Monitoring

### Health Checks

All services expose `/health` endpoints:
- http://localhost:3004/health
- http://localhost:3005/health
- http://localhost:3006/health

### RabbitMQ Management

- URL: http://localhost:15672
- Username: `admin`
- Password: `admin`

### Database Access

```bash
# Connect to SOS database
docker exec -it postgres-sos psql -U postgres -d rescuemesh_sos

# Connect to Matching database
docker exec -it postgres-matching psql -U postgres -d rescuemesh_matching

# Connect to Notification database
docker exec -it postgres-notification psql -U postgres -d rescuemesh_notification
```

---

## 🔐 Production Considerations

1. **Change default passwords** in `docker-compose.yml`
2. **Use secrets management** for sensitive credentials
3. **Enable SSL/TLS** for API Gateway
4. **Set up proper monitoring** (Prometheus, Grafana)
5. **Configure backup** for databases
6. **Set up CI/CD pipeline**

---

## 🤝 Integration with Friend's Services

Your services expect these services to be running:

- **User Service**: `http://user-service:3001`
- **Skill Service**: `http://skill-service:3002`
- **Disaster Service**: `http://disaster-service:3003`

Update `docker-compose.yml` to include these services or configure them separately.

---

## 📝 Next Steps

1. ✅ Services are running
2. ✅ Test API endpoints
3. ✅ Integrate with friend's services
4. ✅ Test end-to-end flow
5. ✅ Prepare demo scenario
6. ✅ Document API usage

---

## 🆘 Need Help?

- Check service logs: `docker-compose logs [service-name]`
- Verify API contracts in `API_CONTRACTS.md`
- Review service README files
