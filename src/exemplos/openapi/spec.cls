Class exemplos.openapi.spec Extends %REST.Spec [ ProcedureBlock ]
{

XData OpenAPI [ MimeType = application/json ]
{
{
  "swagger":"2.0",
  "info":{
    "title":"API de Produtos (CRUD)",
    "version":"1.0.0",
    "description":"Documentação OpenAPI para um CRUD simples de cadastro de produtos.\nInclui endpoints para listar, criar, consultar, atualizar e excluir produtos."
  },
  "basePath":"/v1",
  "schemes":[
    "https",
    "http"
  ],
  "consumes":[
    "application/json"
  ],
  "produces":[
    "application/json"
  ],
  "tags":[
    {
      "name":"Produtos",
      "description":"Operações relacionadas ao cadastro de produtos"
    }
  ],
  "paths":{
    "/products":{
      "get":{
        "tags":[
          "Produtos"
        ],
        "summary":"Listar produtos",
        "description":"Retorna uma lista paginada de produtos. Suporta busca por nome e paginação.",
        "operationId":"ListaProdutos",
        "parameters":[
          {
            "name":"page",
            "in":"query",
            "description":"Número da página (1-based)",
            "type":"integer",
            "format":"int32",
            "minimum":1,
            "default":1
          },
          {
            "name":"limit",
            "in":"query",
            "description":"Quantidade de itens por página",
            "type":"integer",
            "format":"int32",
            "minimum":1,
            "maximum":100,
            "default":20
          },
          {
            "name":"search",
            "in":"query",
            "description":"Texto para buscar pelo nome ou descrição",
            "type":"string"
          }
        ],
        "responses":{
          "200":{
            "description":"Lista de produtos retornada com sucesso",
            "schema":{
              "$ref":"#/definitions/ProductListResponse"
            }
          },
          "500":{
            "$ref":"#/responses/InternalError"
          }
        }
      },
      "post":{
        "tags":[
          "Produtos"
        ],
        "summary":"Criar um novo produto",
        "description":"Cria um produto e retorna o registro criado.",
        "operationId":"CriaProduto",
        "security":[
          {
            "bearerAuth":[
            ]
          }
        ],
        "parameters":[
          {
            "name":"product",
            "in":"body",
            "required":true,
            "schema":{
              "$ref":"#/definitions/ProductCreate"
            },
            "description":"Objeto do produto a ser criado"
          }
        ],
        "responses":{
          "201":{
            "description":"Produto criado com sucesso",
            "schema":{
              "$ref":"#/definitions/Product"
            }
          },
          "400":{
            "$ref":"#/responses/BadRequest"
          },
          "401":{
            "$ref":"#/responses/Unauthorized"
          },
          "500":{
            "$ref":"#/responses/InternalError"
          }
        }
      }
    },
    "/products/{id}":{
      "parameters":[
        {
          "name":"id",
          "in":"path",
          "required":true,
          "description":"ID único do produto (UUID ou inteiro, conforme implementação)",
          "type":"string"
        }
      ],
      "get":{
        "tags":[
          "Produtos"
        ],
        "summary":"Consultar produto por ID",
        "description":"Retorna os detalhes de um produto específico.",
        "operationId":"ConsultaProdutoPorId",
        "responses":{
          "200":{
            "description":"Produto encontrado",
            "schema":{
              "$ref":"#/definitions/Product"
            }
          },
          "404":{
            "$ref":"#/responses/NotFound"
          },
          "500":{
            "$ref":"#/responses/InternalError"
          }
        }
      },
      "put":{
        "tags":[
          "Produtos"
        ],
        "summary":"Atualizar produto (substituição completa)",
        "description":"Substitui todos os campos do produto por valores fornecidos.",
        "operationId":"AtualizaProduto",
        "security":[
          {
            "bearerAuth":[
            ]
          }
        ],
        "parameters":[
          {
            "name":"product",
            "in":"body",
            "required":true,
            "schema":{
              "$ref":"#/definitions/ProductCreate"
            },
            "description":"Objeto com os campos que substituirão o produto existente"
          }
        ],
        "responses":{
          "200":{
            "description":"Produto atualizado com sucesso",
            "schema":{
              "$ref":"#/definitions/Product"
            }
          },
          "400":{
            "$ref":"#/responses/BadRequest"
          },
          "401":{
            "$ref":"#/responses/Unauthorized"
          },
          "404":{
            "$ref":"#/responses/NotFound"
          },
          "500":{
            "$ref":"#/responses/InternalError"
          }
        }
      },
      "patch":{
        "tags":[
          "Produtos"
        ],
        "summary":"Atualizar parcialmente um produto",
        "description":"Atualiza apenas os campos informados do produto.",
        "operationId":"AtualizaProdutoParcial",
        "security":[
          {
            "bearerAuth":[
            ]
          }
        ],
        "parameters":[
          {
            "name":"product",
            "in":"body",
            "required":true,
            "schema":{
              "$ref":"#/definitions/ProductUpdate"
            },
            "description":"Objeto com os campos a serem atualizados (parcial)"
          }
        ],
        "responses":{
          "200":{
            "description":"Produto atualizado com sucesso",
            "schema":{
              "$ref":"#/definitions/Product"
            }
          },
          "400":{
            "$ref":"#/responses/BadRequest"
          },
          "401":{
            "$ref":"#/responses/Unauthorized"
          },
          "404":{
            "$ref":"#/responses/NotFound"
          },
          "500":{
            "$ref":"#/responses/InternalError"
          }
        }
      },
      "delete":{
        "tags":[
          "Produtos"
        ],
        "summary":"Excluir produto",
        "description":"Remove o produto do cadastro.",
        "operationId":"ExcluiProduto",
        "security":[
          {
            "bearerAuth":[
            ]
          }
        ],
        "responses":{
          "204":{
            "description":"Produto excluído com sucesso (sem conteúdo)"
          },
          "401":{
            "$ref":"#/responses/Unauthorized"
          },
          "404":{
            "$ref":"#/responses/NotFound"
          },
          "500":{
            "$ref":"#/responses/InternalError"
          }
        }
      }
    }
  },
  "definitions":{
    "Product":{
      "type":"object",
      "required":[
        "id",
        "name",
        "price",
        "quantity"
      ],
      "properties":{
        "id":{
          "type":"string",
          "description":"Identificador único do produto",
          "example":"b6a1f7e2-3a4b-11ec-8d3d-0242ac120002"
        },
        "name":{
          "type":"string",
          "description":"Nome do produto",
          "example":"Camiseta Básica"
        },
        "description":{
          "type":"string",
          "description":"Descrição detalhada do produto",
          "example":"Camiseta 100% algodão, lavagem simples"
        },
        "price":{
          "type":"number",
          "format":"float",
          "description":"Preço unitário do produto",
          "example":49.9
        },
        "quantity":{
          "type":"integer",
          "description":"Quantidade disponível em estoque",
          "example":120
        },
        "tags":{
          "type":"array",
          "items":{
            "type":"string"
          },
          "description":"Lista de tags/categorias do produto",
          "example":[
            "roupa",
            "verão"
          ]
        },
        "createdAt":{
          "type":"string",
          "format":"date-time",
          "description":"Data de criação do registro",
          "example":"2025-10-14T12:34:56Z"
        },
        "updatedAt":{
          "type":"string",
          "format":"date-time",
          "description":"Data da última atualização do registro",
          "example":"2025-10-14T12:34:56Z"
        }
      }
    },
    "ProductCreate":{
      "type":"object",
      "required":[
        "name",
        "price"
      ],
      "properties":{
        "name":{
          "type":"string"
        },
        "description":{
          "type":"string"
        },
        "price":{
          "type":"number",
          "format":"float"
        },
        "quantity":{
          "type":"integer",
          "default":0
        },
        "tags":{
          "type":"array",
          "items":{
            "type":"string"
          }
        }
      }
    },
    "ProductUpdate":{
      "type":"object",
      "description":"Campos opcionais para atualização parcial",
      "properties":{
        "name":{
          "type":"string"
        },
        "description":{
          "type":"string"
        },
        "price":{
          "type":"number",
          "format":"float"
        },
        "quantity":{
          "type":"integer"
        },
        "tags":{
          "type":"array",
          "items":{
            "type":"string"
          }
        }
      }
    },
    "ProductListResponse":{
      "type":"object",
      "properties":{
        "items":{
          "type":"array",
          "items":{
            "$ref":"#/definitions/Product"
          }
        },
        "total":{
          "type":"integer"
        },
        "page":{
          "type":"integer"
        },
        "limit":{
          "type":"integer"
        }
      }
    }
  },
  "securityDefinitions":{
    "bearerAuth":{
      "type":"apiKey",
      "name":"Authorization",
      "in":"header",
      "description":"Autenticação Bearer JWT. Enviar header: Authorization: Bearer {token}"
    }
  },
  "security":[
    {
      "bearerAuth":[
      ]
    }
  ],
  "responses":{
    "BadRequest":{
      "description":"Requisição inválida (erro de validação)"
    },
    "Unauthorized":{
      "description":"Não autorizado (autenticação necessária)"
    },
    "NotFound":{
      "description":"Recurso não encontrado"
    },
    "InternalError":{
      "description":"Erro interno do servidor"
    }
  },
  "x-servers":[
    {
      "url":"https://api.exemplo.com/v1",
      "description":"Servidor de produção (exemplo)"
    },
    {
      "url":"http://localhost:8080/v1",
      "description":"Servidor local"
    }
  ],
  "x-examples":{
    "curl-list":{
      "summary":"Exemplo curl para listar produtos",
      "value":"curl -X GET \"http://localhost:8080/v1/products?page=1&limit=20\" -H \"Accept: application/json\""
    },
    "curl-create":{
      "summary":"Exemplo curl para criar produto",
      "value":"curl -X POST \"http://localhost:8080/v1/products\" -H \"Content-Type: application/json\" -H \"Authorization: Bearer <token>\" -d '{\"name\":\"Camiseta Básica\",\"price\":49.9,\"quantity\":120}'"
    }
  }
}
}

}
