# caly

exercise of parsing easy expressions

```
$ ruby bin/caly
```

### expression

```
state = IDEN "=" expr EOL | expr EOL
expr = term { (+|-) term }
term = factor { (*|/) factor }
factor = num | iden | "(" expr ")"
iden = IDEN
num = NUM
```
