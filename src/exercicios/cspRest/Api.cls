Class exercicios.cspRest.Api Extends %CSP.REST
{

// Preencha o UrlMap com as rotas necessárias

XData UrlMap
{
<Routes>
</Routes>
}

/// Método a ser implementado no exercício 1
ClassMethod ListaProdutos() As %Library.Status
{
	Try
	{
		// Nesta variável está uma string com a lista de produtos.
		Set listaProdutos = ##class(exercicios.cspRest.Produtos).ListaProdutos()
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
	Try
	{
		// Preencha essa variável com o corpo da requisição
		Set produtoJson = "?"

		// Esse método cria o produto e retorna o JSON com o seu ID.
		Set response = ##class(exercicios.cspRest.Produtos).CriaProduto(produtoJson)
	}
	Catch (exception)
	{
		Return exception.AsStatus()
	}

	Return $$$OK
}

}
