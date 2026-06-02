
{
  "name": "Get tables, schemas, foreign keys",
  "nodes": [
    {
      "parameters": {
        "inputSource": "passthrough"
      },
      "id": "c055762a-8fe7-4141-a639-df2372f30060",
      "typeVersion": 1.1,
      "name": "Cuando se ejecuta el otro workflow",
      "type": "n8n-nodes-base.executeWorkflowTrigger",
      "position": [
        240,
        304
      ]
    },
    {
      "parameters": {
        "aggregate": "aggregateAllItemData",
        "options": {}
      },
      "type": "n8n-nodes-base.aggregate",
      "typeVersion": 1,
      "position": [
        624,
        336
      ],
      "id": "00e7649d-c678-4d82-a4d6-0a92999f4ce4",
      "name": "Aggregate1"
    },
    {
      "parameters": {
        "assignments": {
          "assignments": [
            {
              "id": "1e698c8f-a2a1-4d9c-ac2e-964a59a7b7c6",
              "name": "asignaciones",
              "value": "={{ $json.data }}",
              "type": "string"
            }
          ]
        },
        "options": {}
      },
      "type": "n8n-nodes-base.set",
      "typeVersion": 3.4,
      "position": [
        832,
        320
      ],
      "id": "749a9521-8ce0-4f0b-9ee3-23142d2dc04a",
      "name": "editar campos"
    },
    {
      "parameters": {
        "operation": "select",
        "schema": {
          "__rl": true,
          "mode": "list",
          "value": "public"
        },
        "table": {
          "__rl": true,
          "value": "obtener_lista_de_tablas_y_columnas",
          "mode": "list",
          "cachedResultName": "obtener_lista_de_tablas_y_columnas"
        },
        "options": {}
      },
      "type": "n8n-nodes-base.postgres",
      "typeVersion": 2.6,
      "position": [
        464,
        288
      ],
      "id": "487be38d-0882-4dd9-9b91-9d85a159c2a9",
      "name": "Get tables, schemas, foreign keys",
      "credentials": {
        "postgres": {
          "id": "6qU3qd7eJwkp1usu",
          "name": "Postgres account"
        }
      }
    }
  ],
  "pinData": {},
  "connections": {
    "Cuando se ejecuta el otro workflow": {
      "main": [
        [
          {
            "node": "Get tables, schemas, foreign keys",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Aggregate1": {
      "main": [
        [
          {
            "node": "editar campos",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Get tables, schemas, foreign keys": {
      "main": [
        [
          {
            "node": "Aggregate1",
            "type": "main",
            "index": 0
          }
        ]
      ]
    }
  },
  "active": true,
  "settings": {
    "executionOrder": "v1",
    "availableInMCP": false
  },
  "versionId": "afbe1232-0456-4783-8ce1-c156ccceb947",
  "meta": {
    "templateCredsSetupCompleted": true,
    "instanceId": "e314238cfa0d016c71bd570a318e59fccea41b7e676298257b77517a6f5e650d"
  },
  "id": "CUa4nEMnRwLpgQJF",
  "tags": []
}
