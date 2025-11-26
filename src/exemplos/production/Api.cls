Class exemplos.production.Api Extends %CSP.REST
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
		Do ##class(Ens.Director).CreateBusinessService("REST Pedido Busca Por ID", .businessService)

		// Instanciando classe de Request do BS
		Set bsRequest = ##class(exemplos.production.bs.pedido.buscaPorId.Request).%New()

		// Preenchendo a classe de Request com dados necessários
		Set bsRequest.Id = id

		// Iniciando o BS através do ProcessInput
		Do businessService.ProcessInput(bsRequest, .bsResponse)

		// Usando as variáveis retornadas na Response do BS
		Set %response.Status = bsResponse.HttpStatus
		Write bsResponse.Body
	}
	Catch (exception)
	{
		Return exception.AsStatus()
	}

	Return $$$OK
}

}
