# Synchronisation cours-de-math

Ce dossier contient un seul script de synchronisation :

- `synchro.sh`

## Utilisation

```bash
bash synchro.sh
```

Le script synchronise `cours-de-math` vers `cours-de-math-public`, puis commit et push les changements dans le depot public.

## Regles

- Le dossier prive `cours-de-math` n'est jamais modifie.
- Tout ce qui se rapporte aux evaluations reste prive.
- Les chemins contenant `eval`, `éval`, `interro`, `controle`, `contrôle` ou `test` sont exclus du public.
- Dans `documents`, seul `documents/enseignement` est conserve.
- Dans `resources` ou `ressources`, seul le sous-dossier `enseignement` est conserve.
- Les anciens fichiers publics qui ne respectent plus ces regles sont supprimes.
