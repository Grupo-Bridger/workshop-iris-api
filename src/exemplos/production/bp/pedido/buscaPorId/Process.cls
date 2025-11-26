Class exemplos.production.bp.pedido.buscaPorId.Process Extends Ens.BusinessProcess
{

Method OnRequest(pRequest As exemplos.production.bp.pedido.buscaPorId.Request, Output pResponse As exemplos.production.bp.pedido.buscaPorId.Response) As %Library.Status
{
	Try
	{
		Set boRequest = ##class(exemplos.production.bo.pedido.buscaPorId.Request).%New()

		Set boRequest.Id = pRequest.Id

		$$$ThrowOnError(..SendRequestSync("Pedido", boRequest, .boResponse))

		Do pRequest.NewResponse(.pResponse)

		Set pResponse.Id = boResponse.Id
		Set pResponse.IdCliente = boResponse.IdCliente
		Set pResponse.Valor = boResponse.Valor
	}
	Catch (exception)
	{
		Return exception.AsStatus()
	}

	Return $$$OK
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
