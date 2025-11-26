/// Classe auxiliar para os exercícios 1 e 2.
/// Conteúdo não faz parte deste curso.
Class exercicios.cspRest.Produtos Extends (%Library.Persistent, %JSON.Adaptor)
{

Property Nome As %Library.String(MAXLEN = "");

Property Preco As %Library.Numeric;

Property QuantidadeEstoque As %Library.Integer;

ClassMethod ListaProdutos() As %Library.String
{
	Try
	{
		Set sqlStatement = ##class(%SQL.Statement).%New()

		Set sqlQuery = "SELECT * FROM exercicios_cspRest.Produtos"

		$$$ThrowOnError(sqlStatement.%Prepare(sqlQuery))
		#Dim sqlResult As %SQL.StatementResult = sqlStatement.%Execute()

		Set list = []

		While (sqlResult.%Next())
		{
			Set result = {}

			Set result.id = sqlResult.%Get("ID")
			Set result.nome = sqlResult.%Get("Nome")
			Set result.preco = sqlResult.%Get("Preco")
			Set result.quantidadeEstoque = sqlResult.%Get("QuantidadeEstoque")

			Do list.%Push(result)
		}

		Return list.%ToJSON()
	}
	Catch (exception)
	{
		Set body = ##class(%Library.DynamicObject).%New()
		Set body.error = ##class(%Library.DynamicObject).%New()

		If (exception.%IsA("%Exception.General"))
		{
			Set body.error.code = exception.Code
			Set body.error.displayMessage = exception.Name
		}
		Else
		{
			Set body.error.code = exception.Code
			Set body.error.displayMessage = exception.Name
		}

		Set body.error.technicalMessage = exception.DisplayString()

		Return body.%ToJSON()
	}

	Return "{""message"": ""Erro Desconhecido""}"
}

ClassMethod CriaProduto(pProdutoJson As %Library.String) As %Library.String
{
	Try
	{
		Set produtoObj = ##class(%Library.DynamicObject).%FromJSON(pProdutoJson)

		Set produtoData = ##class(exercicios.cspRest.Produtos).%New()

		Set produtoData.Nome = produtoObj.nome
		Set produtoData.Preco = produtoObj.preco
		Set produtoData.QuantidadeEstoque = produtoObj.quantidadeEstoque

		$$$ThrowOnError(produtoData.%Save())

		Set result = {}

		Set result.id = produtoData.%Id()

		Return result.%ToJSON()
	}
	Catch (exception)
	{
		Set body = ##class(%Library.DynamicObject).%New()
		Set body.error = ##class(%Library.DynamicObject).%New()

		If (exception.%IsA("%Exception.General"))
		{
			Set body.error.code = exception.Code
			Set body.error.displayMessage = exception.Name
		}
		Else
		{
			Set body.error.code = exception.Code
			Set body.error.displayMessage = exception.Name
		}

		Set body.error.technicalMessage = exception.DisplayString()

		Return body.%ToJSON()
	}

	Return "{""message"": ""Erro Desconhecido""}"
}

Storage Default
{
<Data name="ProdutosDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Nome</Value>
</Value>
<Value name="3">
<Value>Preco</Value>
</Value>
<Value name="4">
<Value>QuantidadeEstoque</Value>
</Value>
</Data>
<DataLocation>^exercicios.cspRest.ProdutosD</DataLocation>
<DefaultData>ProdutosDefaultData</DefaultData>
<IdLocation>^exercicios.cspRest.ProdutosD</IdLocation>
<IndexLocation>^exercicios.cspRest.ProdutosI</IndexLocation>
<StreamLocation>^exercicios.cspRest.ProdutosS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
