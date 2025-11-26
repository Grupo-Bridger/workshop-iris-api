Class exercicios.production.Api Extends %CSP.REST
{

XData UrlMap
{
<Routes>
	<Route Url="/pedido/:id" Method="GET" Call="BuscaPedidoPorId"/>
</Routes>
}

ClassMethod BuscaPedidoPorId(id) As %Library.Status
{
	Set %response.ContentType = "application/json"
	Set %response.CharSet = "utf-8"

	Try
	{
		// Usando o Ens.Director para pegar uma
		// referência ao BS que está na Production

		// Instanciando classe de Request do BS

		// Preenchendo a classe de Request com dados necessários

		// Iniciando o BS através do ProcessInput

		// Usando as variáveis retornadas na Response do BS
		Set %response.Status = ""
		Write ""
	}
	Catch (exception)
	{
		Return exception.AsStatus()
	}

	Return $$$OK
}

}
