# Guia de CORS no InterSystems IRIS

## Configuração de CORS a Nível de Classe

### Parameter HandleCorsRequest

```objectscript
Parameter HandleCorsRequest = 1;
```

**Como funciona:**

- Quando `= 1`, o runtime do IRIS processa requisições CORS de uma maneira padrão
- Esta configuração padrão é bem permissiva, então não é recomendado que você a utilize
- Ao invés disso, você deve implementar o método OnHandleCorsRequest com configurações específicas para a sua aplicação

### Método OnHandleCorsRequest

Ao habilitar o parâmetro `HandleCorsRequest`, você pode implementar o método `OnHandleCorsRequest` para criar configurações personalizadas de CORS válidas para toda a classe:

```objectscript
/// Método para controlar o CORS
ClassMethod OnHandleCorsRequest(url As %Library.String) As %Library.Status
{
    Try
    {
        // Permitir endereço de origem
        Do %response.SetHeaderIfEmpty("Access-Control-Allow-Origin", "https://meu-frontend.com")

        // Permitir envio de cookies/credenciais
        Do %response.SetHeader("Access-Control-Allow-Credentials","true")

        // Permitir headers customizados na request
        Do %response.SetHeaderIfEmpty("Access-Control-Allow-Headers", "X-Customizado-Request")

        // Headers que o cliente pode ler na resposta
        Do %response.SetHeader("Access-Control-Expose-Headers","Content-Length, X-Customizado-Response")

        // Permitir métodos específicos
        Do %response.SetHeaderIfEmpty("Access-Control-Allow-Methods", "POST, PUT, PATCH")

        // Por quanto tempo o preflight pode ser cacheado (em segundos)
        Do %response.SetHeader("Access-Control-Max-Age","3600")
    }
    Catch (exception)
    {
        Return exception.AsStatus()
    }

    Return $$$OK
}
```

---

## 🛣️ Configuração de CORS a Nível de Rota

Também é possível habilitar CORS por rota específica no `UrlMap`:

```xml
<Route Url="/myapp/*" Method="*" Class="MyApp.REST.Api" Cors="true" />
```

O atributo `Cors="true"` tem efeito similar ao `HandleCorsRequest`, mas aplicado apenas à rota específica.

## Referências e recursos

- [Documentação oficial do InterSystems sobre CORS](https://docs.intersystems.com)
- [MDN Web Docs - CORS](https://developer.mozilla.org/pt-BR/docs/Web/HTTP/CORS)
