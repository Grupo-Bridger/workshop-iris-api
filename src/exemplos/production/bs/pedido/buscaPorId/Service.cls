Class exemplos.production.bs.pedido.buscaPorId.Service Extends Ens.BusinessService
{

Method OnProcessInput(pRequest As exemplos.production.bs.pedido.buscaPorId.Request, Output pResponse As exemplos.production.bs.pedido.buscaPorId.Response) As %Library.Status
{
	Try
	{
		$$$ThrowOnError(pRequest.NewResponse(.pResponse))

		Set bpRequest = ##class(exemplos.production.bp.pedido.buscaPorId.Request).%New()

		Set bpRequest.Id = pRequest.Id

		$$$ThrowOnError(..SendRequestSync("Pedido Busca Por ID", bpRequest, .bpResponse))

		Set pResponse.HttpStatus = ##class(%CSP.REST).#HTTP200OK
		Set body = {}
		Set body.id = bpResponse.Id
		Set body.idCliente = bpResponse.IdCliente
		Set body.valor = bpResponse.Valor

		Set pResponse.Body = body.%ToJSON()
	}
	Catch (exception)
	{
		Set body = ##class(%Library.DynamicObject).%New()
		Set body.error = ##class(%Library.DynamicObject).%New()

		If (exception.%IsA("%Exception.General"))
		{
			Set pResponse.HttpStatus = ##class(%CSP.REST).#HTTP400BADREQUEST
			Set body.error.code = exception.Code
			Set body.error.displayMessage = exception.Name
		}
		Else
		{
			Set pResponse.HttpStatus = ##class(%CSP.REST).#HTTP500INTERNALSERVERERROR
			Set body.error.code = exception.Code
			Set body.error.displayMessage = exception.Name
		}

		Set body.error.technicalMessage = exception.DisplayString()
		Set body.error.sessionId = ""
		Set pResponse.Body = body.%ToJSON()
	}

	Return $$$OK
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
