#!/bin/bash

# RescueMesh System Verification Script
# This script checks if all components are running correctly

echo "🆘 RescueMesh System Verification"
echo "=================================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if docker-compose is running
echo "📦 Checking Docker Compose..."
if ! docker compose ps > /dev/null 2>&1; then
    echo -e "${RED}❌ Docker Compose is not running${NC}"
    echo "   Run: docker compose up -d --build"
    exit 1
fi
echo -e "${GREEN}✓ Docker Compose is running${NC}"
echo ""

# Check container count
echo "🔍 Checking Containers..."
EXPECTED_CONTAINERS=17
RUNNING_CONTAINERS=$(docker compose ps --format json | jq -s 'length')

if [ "$RUNNING_CONTAINERS" -eq "$EXPECTED_CONTAINERS" ]; then
    echo -e "${GREEN}✓ All $EXPECTED_CONTAINERS containers are running${NC}"
else
    echo -e "${YELLOW}⚠ Expected $EXPECTED_CONTAINERS containers, found $RUNNING_CONTAINERS${NC}"
fi
echo ""

# Check individual services
echo "🌐 Checking Services..."

check_service() {
    local name=$1
    local url=$2
    local port=$3
    
    if curl -s "$url" > /dev/null 2>&1; then
        echo -e "${GREEN}✓${NC} $name (port $port)"
        return 0
    else
        echo -e "${RED}✗${NC} $name (port $port) - NOT RESPONDING"
        return 1
    fi
}

# Check frontend
check_service "Frontend" "http://localhost:3000/health" "3000"

# Check API Gateway
check_service "API Gateway" "http://localhost:8000/health" "8000"

# Check backend services
check_service "User Service" "http://localhost:3001/health" "3001"
check_service "Skill Service" "http://localhost:3002/health" "3002"
check_service "Disaster Service" "http://localhost:3003/health" "3003"
check_service "SOS Service" "http://localhost:3004/health" "3004"
check_service "Matching Service" "http://localhost:3005/health" "3005"
check_service "Notification Service" "http://localhost:3006/health" "3006"

echo ""

# Check RabbitMQ
echo "🐰 Checking RabbitMQ..."
if curl -s -u admin:admin "http://localhost:15672/api/overview" > /dev/null 2>&1; then
    echo -e "${GREEN}✓${NC} RabbitMQ Management (port 15672)"
else
    echo -e "${YELLOW}⚠${NC} RabbitMQ Management - may still be starting"
fi

echo ""

# Check PostgreSQL databases
echo "🗄️ Checking PostgreSQL Databases..."
POSTGRES_DBS=("postgres-users:5431" "postgres-skills:5432" "postgres-disasters:5433" "postgres-sos:5434" "postgres-matching:5435" "postgres-notification:5436")

for db in "${POSTGRES_DBS[@]}"; do
    IFS=':' read -r container port <<< "$db"
    if docker exec "$container" pg_isready -U postgres > /dev/null 2>&1; then
        echo -e "${GREEN}✓${NC} $container (port $port)"
    else
        echo -e "${RED}✗${NC} $container (port $port) - NOT READY"
    fi
done

echo ""

# Check Redis instances
echo "💾 Checking Redis Caches..."
REDIS_INSTANCES=("redis-users:6371" "redis-skills:6372" "redis-disasters:6373" "redis-sos:6374" "redis-matching:6375" "redis-notification:6376")

for redis in "${REDIS_INSTANCES[@]}"; do
    IFS=':' read -r container port <<< "$redis"
    if docker exec "$container" redis-cli ping > /dev/null 2>&1; then
        echo -e "${GREEN}✓${NC} $container (port $port)"
    else
        echo -e "${RED}✗${NC} $container (port $port) - NOT READY"
    fi
done

echo ""
echo "=================================="
echo ""

# Test a simple API call
echo "🧪 Testing API Gateway..."
if curl -s "http://localhost:8000/api/users/health" | grep -q "healthy\|ok\|OK"; then
    echo -e "${GREEN}✓ API Gateway is routing correctly${NC}"
else
    echo -e "${YELLOW}⚠ API Gateway routing may have issues${NC}"
fi

echo ""

# Frontend accessibility test
echo "🎨 Testing Frontend..."
if curl -s "http://localhost:3000" | grep -q "RescueMesh\|root"; then
    echo -e "${GREEN}✓ Frontend is serving correctly${NC}"
else
    echo -e "${RED}✗ Frontend is not accessible${NC}"
fi

echo ""
echo "=================================="
echo ""

# Summary
echo "📊 System Summary"
echo "=================================="
echo ""
echo "Access Points:"
echo "  🌐 Frontend:      http://localhost:3000"
echo "  🔌 API Gateway:   http://localhost:8000"
echo "  🐰 RabbitMQ UI:   http://localhost:15672 (admin/admin)"
echo ""
echo "Quick Commands:"
echo "  View logs:        docker compose logs -f"
echo "  Restart all:      docker compose restart"
echo "  Stop all:         docker compose down"
echo "  Rebuild:          docker compose up -d --build"
echo ""

# Final status
FAILED_COUNT=$(docker compose ps --format json | jq -s '[.[] | select(.Health != "healthy" and .State != "running")] | length')

if [ "$FAILED_COUNT" -eq 0 ]; then
    echo -e "${GREEN}🎉 All systems operational!${NC}"
    echo -e "${GREEN}   Open http://localhost:3000 to start using RescueMesh${NC}"
else
    echo -e "${YELLOW}⚠ Some services may need attention${NC}"
    echo "   Check logs with: docker compose logs"
fi

echo ""
