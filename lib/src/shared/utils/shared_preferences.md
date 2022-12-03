# Shared preferences plugin

### Agrupa o armazenamento persistente específico da plataforma para dados simples (NSUserDefaults no iOS e macOS, SharedPreferences no Android etc.). Os dados podem ser persistidos no disco de forma assíncrona e não há garantia de que as gravações serão persistidas no disco após o retorno, portanto, este plug-in não deve ser usado para armazenar dados críticos.
# _______________________________________________________________

### Os tipos de dados suportados são int, double, boole String.List<String>


## Uso 
### Para usar este plug-in, adicione shared_preferencescomo uma dependência em seu arquivo pubspec.yaml .

## Exemplos 
### Aqui estão pequenos exemplos que mostram como usar a API.
# _______________________________________________________________

## Gravar dados

### // Obtém preferências compartilhadas. preferências 
#### <span style ="color:yellow">final = await SharedPreferences.getInstance()</span>; 

### // Salva um valor inteiro na chave 'counter'. 
#### <span style ="color:yellow">await prefs.setInt('counter', 10)</span>; 

### // Salva um valor booleano na chave 'repeat'. 
#### <span style ="color:yellow">await prefs.setBool('repeat', true)</span>; 

### // Salva um valor double na chave 'decimal'. 
#### <span style ="color:yellow">await prefs.setDouble('decimal', 1.5)</span>; 

### // Salva um valor String na chave 'action'. 
#### <span style ="color:yellow">await prefs.setString('action', 'Start')</span>; 

### // Salva uma lista de strings na chave 'items'. 
### <span style ="color:yellow">await prefs.setStringList('items', <String>['Terra', 'Lua', 'Sol'])</span>;

# _______________________________________________________________

## Ler dados

### // Tente ler os dados da chave 'counter'. Se não existir, retorna null. 
#### <span style ="color:yellow">final int? counter = prefs.getInt('counter')</span>; 

### // Tente ler os dados da tecla 'repeat'. Se não existir, retorna null. 
#### <span style ="color:yellow">final bool? repeat = prefs.getBool('repeat')</span>; 

#### // Tente ler os dados da chave 'decimal'. Se não existir, retorna null. 
### <span style ="color:yellow">final double? decimal = prefs.getDouble('decimal')</span>; 

### // Tente ler os dados da chave 'action'. Se não existir, retorna null. 
#### <span style ="color:yellow">final String? action = prefs.getString('action')</span>; 

### // Tente ler os dados da chave 'items'. Se não existir, retorna null. 
#### <span style ="color:yellow">final List<String>? items = prefs.getStringList('items')</span>;