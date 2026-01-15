# Tech Stack Explanation for RescueMesh

## 🎯 Why These Technologies?

### **Node.js + Express**
✅ **Fast Development**: Quick to prototype and iterate  
✅ **Async by Default**: Perfect for I/O-heavy microservices  
✅ **Rich Ecosystem**: Tons of packages (axios, joi, winston)  
✅ **Lightweight**: Small Docker images  
✅ **Hackathon-Friendly**: Easy to explain and demo  

**Alternative**: Python + FastAPI (also great, but Node.js is faster for REST APIs)

---

### **PostgreSQL**
✅ **Reliable**: ACID compliance for critical data  
✅ **JSON Support**: JSONB for flexible schemas (skills, resources)  
✅ **Mature**: Battle-tested, great for production  
✅ **Spatial Queries**: Can add PostGIS for location queries later  

**Why not MongoDB?**: PostgreSQL's JSONB gives flexibility + relational benefits

---

### **Redis**
✅ **Caching**: Fast lookups for frequently accessed data  
✅ **Pub/Sub**: Real-time notifications (optional)  
✅ **Session Storage**: If you add auth later  
✅ **Rate Limiting**: Can implement rate limiting  

**Use Cases in Your Services:**
- Cache disaster data
- Cache user locations
- Cache match results

---

### **RabbitMQ**
✅ **Reliable Messaging**: Guaranteed delivery  
✅ **Decoupling**: Services don't need to know about each other  
✅ **Scalability**: Handle high message volumes  
✅ **Management UI**: Easy to monitor (port 15672)  

**Message Flow:**
```
SOS Service → RabbitMQ → Matching Service
Matching Service → RabbitMQ → Notification Service
```

**Alternative**: Redis Pub/Sub (simpler, but less reliable)

---

### **Docker + Docker Compose**
✅ **Mandatory for Hackathon**: Shows DevOps skills  
✅ **Consistency**: Same environment everywhere  
✅ **Easy Deployment**: One command to start everything  
✅ **Isolation**: Each service in its own container  

**Why Separate Databases?**
- Each service has its own database (microservices best practice)
- Can scale independently
- Easier to manage

---

### **Nginx as API Gateway**
✅ **Simple**: Easy to configure  
✅ **Fast**: High performance  
✅ **Rate Limiting**: Built-in  
✅ **Load Balancing**: Can add later  

**Why not Kong?**
- Kong is more powerful but complex
- Nginx is simpler for hackathon
- Can upgrade to Kong later

---

## 📦 Package Choices

### **axios**
- HTTP client for inter-service communication
- Better than `fetch` (supports timeouts, interceptors)

### **joi**
- Request validation
- Type-safe schemas
- Clear error messages

### **winston**
- Structured logging
- Easy to integrate with monitoring tools
- Production-ready

### **amqplib**
- RabbitMQ client
- Official library
- Reliable

### **pg (node-postgres)**
- PostgreSQL client
- Connection pooling built-in
- Async/await support

### **redis**
- Official Redis client
- Modern async API
- TypeScript support (if you migrate later)

---

## 🔄 Service Communication Patterns

### **Synchronous (REST)**
```javascript
// Direct HTTP call
const response = await axios.get('http://user-service:3001/api/users/123');
```
**Use for**: Immediate data needs, simple operations

### **Asynchronous (Message Queue)**
```javascript
// Publish event
publishToQueue('matching.trigger', { event: 'sos.request.created', data: {...} });
```
**Use for**: Decoupled operations, notifications, triggers

---

## 🏗️ Architecture Decisions

### **Why Separate Databases?**
- ✅ True microservices (each service owns its data)
- ✅ Can use different databases if needed
- ✅ Independent scaling
- ✅ No shared database bottlenecks

### **Why Redis per Service?**
- ✅ Isolation
- ✅ Can scale independently
- ✅ Different cache strategies per service

### **Why Message Queue?**
- ✅ Decoupling
- ✅ Resilience (messages persist)
- ✅ Scalability (can add more workers)

---

## 🚀 Scaling Considerations

### **Horizontal Scaling**
```yaml
# In docker-compose.yml, you can add:
sos-service-2:
  # ... same config
  scale: 2
```

### **Database Scaling**
- Read replicas for PostgreSQL
- Redis Cluster for high availability

### **Message Queue Scaling**
- RabbitMQ clustering
- Multiple consumers per queue

---

## 🔐 Security (For Production)

### **Current (MVP/Hackathon)**
- Basic CORS
- Environment variables
- No authentication (for speed)

### **Production Additions**
- JWT authentication
- API keys
- Rate limiting (already in nginx)
- HTTPS/TLS
- Secrets management (Vault, AWS Secrets Manager)
- Input sanitization (already with Joi)

---

## 📊 Monitoring Stack (Optional for Hackathon)

### **Prometheus + Grafana**
- Metrics collection
- Beautiful dashboards
- Alerting

### **ELK Stack (Elasticsearch, Logstash, Kibana)**
- Centralized logging
- Log analysis
- Search

### **Jaeger/Zipkin**
- Distributed tracing
- See request flow across services

---

## 🧪 Testing Stack

### **Jest**
- Unit tests
- Integration tests
- Mocking

### **Supertest**
- API testing
- End-to-end tests

### **Postman/Newman**
- API testing
- Collection runner
- CI/CD integration

---

## 📱 External Services

### **Twilio (SMS)**
- Reliable SMS delivery
- Global coverage
- Easy API
- **Cost**: ~$0.0075 per SMS

### **Firebase Cloud Messaging (Push)**
- Free tier available
- Cross-platform
- Easy integration
- **Alternative**: OneSignal (also free)

---

## 🎓 Learning Resources

- **Docker**: https://docs.docker.com/
- **RabbitMQ**: https://www.rabbitmq.com/documentation.html
- **PostgreSQL**: https://www.postgresql.org/docs/
- **Node.js Best Practices**: https://github.com/goldbergyoni/nodebestpractices

---

## 💡 Hackathon Tips

1. **Start Simple**: Get basic flow working first
2. **Mock External Services**: Don't wait for friend's services
3. **Use Docker**: Shows DevOps skills
4. **Document APIs**: Helps judges understand
5. **Demo End-to-End**: Show complete disaster scenario
6. **Highlight Architecture**: Explain microservices benefits

---

## 🔄 Migration Path (If Time Permits)

### **Phase 1 (Current)**
- Node.js + Express
- PostgreSQL
- RabbitMQ
- Docker Compose

### **Phase 2 (If Time)**
- Add Kubernetes
- Add monitoring (Prometheus)
- Add authentication (JWT)
- Add API documentation (Swagger)

### **Phase 3 (Future)**
- Service mesh (Istio)
- GraphQL API
- Event sourcing
- CQRS pattern

---

## ✅ Checklist for Hackathon

- [x] Docker Compose setup
- [x] All services containerized
- [x] API Gateway configured
- [x] Health checks implemented
- [x] Message queue working
- [x] Database schemas created
- [x] API contracts documented
- [ ] Integration tests
- [ ] Demo scenario prepared
- [ ] Presentation ready
