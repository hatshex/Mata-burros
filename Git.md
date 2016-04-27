En github no puedes subir archivos mayores a 100MB, si te llega a suceder, tienes que quitar el archivo del branch con la instrucción:

```shell
git filter-branch -f --index-filter 'git rm --cached --ignore-unmatch dpabase.tar'
```
