//Validar formulário
mixin ValidationMixin {

  //Verifica se o input não está vazio
  String? isNotEmpty(String? value, [String? message]) {
    if (value!.isNotEmpty) return message ?? "Este campo é obrigatório";
    return null;
  }

  //Verifica o requisito minímo de caracteres
  String? hasXChars(String? value, [String? message, int quantidade = 5]) {
    if (value!.length < quantidade) {
      return message ?? "Você deve usar $quantidade caracteres ou mais!";
    }
    return null;
  }

  //Conbina uma lista de funções de validações
  //Conbina diferentes regras de validações
  String? combine(List<String? Function()> validators) {
    for (final func in validators) {
      final validation = func();
      if (validation != null) return validation;
    }
    return null;
  }
}


//Exemplo de uso - é aplicado atraves de "with" na classe state
//class nomeClaseState extends clsseState<> with nomeDoMixin{...}
//Exemplo de uso no widget
//validator:isNotEmpty[PADÃO] ou (value)=>isNotEmpty(value,message)
//Pode ser criado uma classe de constantes de messagens
//Exemplo de conbine
/* validator: (value)=> combine([
  ()=> isNotEmpty(value)
  ()=> hasXChars(value,message,quantidade)
]) */
//Fonte:https://youtu.be/HgFstMmYLok