Class exercicio1.Api Extends %CSP.REST
{

/// Mapa de URLs
XData UrlMap
{
<Routes>
	<Route Url="/" Method="GET" Call="Test"/>
</Routes>
}

/// Método a ser chamado quando a API for executada.
ClassMethod Test() As %Library.Status
{
	Try
	{
		Set %response.Status = ..#HTTP200OK
		Set %response.CharSet = "UTF-8"
		Set %response.ContentType = "applicaton/json"

		Write "{""message"": ""hello""}"
	}
	Catch (exception)
	{
		Return exception.AsStatus()
	}

	Return $$$OK
}

}
