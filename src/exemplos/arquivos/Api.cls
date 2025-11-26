Class exemplos.arquivos.Api Extends %CSP.REST
{

XData UrlMap
{
<Routes>
	<Route Url="/download/:filename" Method="GET" Call="Download"/>
	<Route Url="/upload" Method="POST" Call="Upload"/>
</Routes>
}

ClassMethod Download(filename As %Library.String) As %Library.Status
{
	Try
	{
		// Caminho da pasta onde ficarão os arquivos
		Set basePath = "/files/"

		// Validando se o caminho existe
		If ('##class(%Library.File).DirectoryExists(basePath))
		{
			Throw ##class(%Exception.General).%New("Base path not found.", 404)
		}

		// Setando nome do arquivo. O método NormalizeFilename
		// vai tratar o nome do arquivo e retornar o path completo
		// para usarmos ao abrir o arquivo
		Set filepath = ##class(%Library.File).NormalizeFilename(basePath _ filename)

		// Validando se arquivo existe
		If ('##class(%Library.File).Exists(filepath))
		{
			Throw ##class(%Exception.General).%New("File not found.", 404)
		}

		// Instanciando uma referência ao arquivo na memória
		Set file = ##class(%Library.File).%New(filepath)

		// Abrindo o arquivo nos modos:
		// R - Read
		// S - Stream
		// U - Use
		$$$ThrowOnError(file.Open("RSU"))

		// Escolhendo o ContentType apropriado
		Set %response.ContentType = "application/pdf"

		// Escrevendo o arquivo até o final no output da API
		While ('file.AtEnd)
		{
			Write file.Read()
		}

		Do file.Close()
	}
	Catch (exception)
	{
		Return exception.AsStatus()
	}

	Return $$$OK
}

/// Upload de arquivos usando multipart/form-data
ClassMethod Upload() As %Library.Status
{
	Try
	{
		// Caminho da pasta onde ficarão os arquivos
		Set basePath = "/files/"

		// Validando se o caminho existe
		If ('##class(%Library.File).DirectoryExists(basePath))
		{
			Throw ##class(%Exception.General).%New("Base path not found.", 404)
		}

		// Para ler o arquivo da requisição, usar o método GetMimeData
		Set sourceFile = %request.GetMimeData("file")

		// Pegando o nome do arquivo enviado
		Set filename = sourceFile.FileName

		// Setando nome do arquivo. O método NormalizeFilename
		// vai tratar o nome do arquivo e retornar o path completo
		// para usarmos ao abrir o arquivo
		Set filepath = ##class(%Library.File).NormalizeFilename(basePath _ filename)

		// Validando se arquivo existe
		If (##class(%Library.File).Exists(filepath))
		{
			Throw ##class(%Exception.General).%New("There is already a file with this name.", 409)
		}

		// Instanciando uma referência ao arquivo na memória
		Set file = ##class(%Library.File).%New(filepath)

		// Abrindo o arquivo nos modos:
		// N - New
		// W - Write
		// S - Stream
		Do file.Open("NWS")

		// Copiando a Stream de entrada para o arquivo
		Do file.CopyFrom(sourceFile)

		// Fechando o arquivo
		Do file.Close()
	}
	Catch (exception)
	{
		Return exception.AsStatus()
	}

	Return $$$OK
}

}
