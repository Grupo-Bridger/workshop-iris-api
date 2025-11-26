Class exercicios.production.bo.pedido.Operation Extends Ens.BusinessOperation
{

XData MessageMap
{
<MapItems>
	<MapItem MessageType="exercicios.production.bo.pedido.buscaPorId.Request">
		<Method>BuscaPorId</Method>
	</MapItem>
</MapItems>
}

Method BuscaPorId(pRequest As exercicios.production.bo.pedido.buscaPorId.Request, Output pResponse As exercicios.production.bo.pedido.buscaPorId.Response) As %Library.Status
{
	Try
	{
		Do pRequest.NewResponse(.pResponse)

		Set pResponse.Id = pRequest.Id
		Set pResponse.IdCliente = "Exemplo"
		Set pResponse.Valor = 0.5 * pRequest.Id
	}
	Catch (exception)
	{
		Return exception.AsStatus()
	}

	Return $$$OK
}

}
