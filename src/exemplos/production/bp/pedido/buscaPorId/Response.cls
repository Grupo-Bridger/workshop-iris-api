Class exemplos.production.bp.pedido.buscaPorId.Response Extends Ens.Response
{

Property Id As %Library.Integer;

Property IdCliente As %Library.String;

Property Valor As %Library.Numeric;

Storage Default
{
<Data name="ResponseDefaultData">
<Subscript>"Response"</Subscript>
<Value name="1">
<Value>Id</Value>
</Value>
<Value name="2">
<Value>IdCliente</Value>
</Value>
<Value name="3">
<Value>Valor</Value>
</Value>
</Data>
<DefaultData>ResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
