Class exemplos.cors.ApiPorClasse Extends %CSP.REST
{

Parameter HandleCorsRequest = 1;

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
	   	Do %response.SetHeaderIfEmpty("Access-Control-Allow-Headers", "MEU-HEADER-CUSTOMIZADO")

		// Headers que o cliente pode ler na resposta
		Do %response.SetHeader("Access-Control-Expose-Headers","Content-Length, X-My-Header")

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

XData UrlMap
{
<Routes>
	<Route Url="/" Method="GET" Call="GetExample"/>
	<Route Url="/" Method="POST" Call="PostExample"/>
	<Route Url="/" Method="PUT" Call="PutExample"/>
	<Route Url="/" Method="PATCH" Call="PatchExample"/>
	<Route Url="/" Method="DELETE" Call="DeleteExample"/>
</Routes>
}

ClassMethod GetExample()
{
	Write "{""response"": ""success!""}"
	Return $$$OK
}

ClassMethod PostExample()
{
	Write "{""response"": ""success!""}"
	Return $$$OK
}

ClassMethod PutExample()
{
	Write "{""response"": ""success!""}"
	Return $$$OK
}

ClassMethod PatchExample()
{
	Write "{""response"": ""success!""}"
	Return $$$OK
}

ClassMethod DeleteExample()
{
	Write "{""response"": ""success!""}"
	Return $$$OK
}

}
