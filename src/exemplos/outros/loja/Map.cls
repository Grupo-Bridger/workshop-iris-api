Class exemplos.cspRest.loja.Map Extends %CSP.REST
{

/// Exemplo do roteamento de mensagens usando prefixos.
/// A ordem dos mapeamentos é extremamente importante,
/// pois a requisição irá seguir a primeira rota que ele
/// se encaixar.
/// Por exemplo, o método "CadastrarUsuario" nunca será chamado
/// nesta classe, pois a requisição /loja/cadastro já teria sido
/// roteada para a classe exemplos.cspRest.loja.Outros
XData UrlMap
{
<Routes>
	<Map Prefix="/loja/admin" Forward="exemplos.cspRest.loja.Admin" />
	<Map Prefix="/loja/vendas" Forward="exemplos.cspRest.loja.Vendas" />
	<Map Prefix="/loja" Forward="exemplos.cspRest.loja.Outros" />
	<Route Url="/loja/cadastro" Method="POST" Call="CadastrarUsuario"/>
</Routes>
}

/// Não será chamado devido a ordem das rotas acima.
ClassMethod CadastrarUsuario()
{
	Return $$$OK
}

}
