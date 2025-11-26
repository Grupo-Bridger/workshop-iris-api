Class exemplos.cspRest.Api Extends %CSP.REST
{

// Preencha o UrlMap com as rotas necessárias

XData UrlMap
{
<Routes>
	<Route Url="/produtos" Method="GET" Call="ListaProdutos"/>
	<Route Url="/produto" Method="POST" Call="CriaProduto"/>
</Routes>
}

/// Método a ser implementado no exercício 1
ClassMethod ListaProdutos() As %Library.Status
{
	Set %response.ContentType = "application/json"

	Try
	{
		// Nesta variável está uma string com a lista de produtos.
		Set listaProdutos = ##class(exemplos.cspRest.Produtos).ListaProdutos()

		Write listaProdutos
	}
	Catch (exception)
	{
		Return exception.AsStatus()
	}

	Return $$$OK
}

/// Método a ser implementado no exercício 2
ClassMethod CriaProduto() As %Library.Status
{
	Set %response.ContentType = "application/json"

	Try
	{
		// Preencha essa variável com o corpo da requisição
		Set produtoJson = %request.Content.Read()

		// Esse método cria o produto e retorna o JSON com o seu ID.
		Set response = ##class(exemplos.cspRest.Produtos).CriaProduto(produtoJson)

		Write response
	}
	Catch (exception)
	{
		Return exception.AsStatus()
	}

	Return $$$OK
}

}
