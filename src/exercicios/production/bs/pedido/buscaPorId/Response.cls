Class exercicios.production.bs.pedido.buscaPorId.Response Extends Ens.Response
{

Property HttpStatus As %Library.String;

Property Body As %Library.String;

Storage Default
{
<Data name="ResponseDefaultData">
<Subscript>"Response"</Subscript>
<Value name="1">
<Value>HttpStatus</Value>
</Value>
<Value name="2">
<Value>Body</Value>
</Value>
</Data>
<DefaultData>ResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
