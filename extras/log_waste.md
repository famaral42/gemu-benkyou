# To-DO
- [ ] pygame Testar melhor o nuitka
- [ ] pygame Target Android
- [ ] monogame Target Linux, testar um jogo qualquer feito por qualquer um
- [ ] monogame Target Android
- [ ] love2d Target Android


# Journals

---
## 2023


## 05/out

#### Pygame

Deu trabalho criar o _"executável"_ usando o **pyinstaller**. Teve rolo da importação das figuras, tive que usar o caminho relativo.  
E o jogo .exe precisa ficar no mesmo que nível que as pastas de assets

Tentei rapidamente o tal **nuitka**, mas sem sucesso

#### Monogame

Monogame está um saco de instalar **dentro do container** (estamos usando [podman](https://podman.io/)). Não fica claro quais são as bibliotecas necessárias, conseguimos fazer a tela azul abrir, mas o tal **mgcb-editor** não rodou nem a pau.  
Fora do container, no Mint o mgcb-editor chegou a abrir, meio bugado, mas abril

      
#### Love2D
Show de bola, roda de boa no Linux, super fácil gerar o **AppImage**. A versão web conseguimos com o [love.js](https://github.com/Davidobot/love.js), mas só ocnseguir executar usando a sugestão de criar um **servidor pelo python**. Sei que da para gerar um arquivo só, ou pelo menos um **html clicável** porque pelo [LÖVE Web Builder - Package Your Game](https://schellingb.github.io/LoveWebBuilder/package) funciona.
