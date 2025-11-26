Class exemplos.production.bp.pedido.buscaPorId.Request Extends Ens.Request
{

Parameter RESPONSECLASSNAME = "exemplos.production.bp.pedido.buscaPorId.Response";

Property Id As %Library.Integer;

Storage Default
{
<Data name="RequestDefaultData">
<Subscript>"Request"</Subscript>
<Value name="1">
<Value>Id</Value>
</Value>
</Data>
<DefaultData>RequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
