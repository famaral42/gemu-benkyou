# To-DO
- [ ] pygame Testar melhor o nuitka
- [ ] pygame Target Android
- [ ] monogame Target Linux, testar um jogo qualquer feito por qualquer um
- [ ] monogame Target Android
- [x] love2d Target Windows
- [x] love2d Target Linux
- [x] love2d Target Web
- [ ] love2d Target Android _WIP_
- [ ] Phaser Web
- [ ] Phaser Android


# Journals

---

## 2025

### 14/out

Praticamente um ano certinho adormecido. Então, pygbag está bem mais promissor.  
Phaser relamente é pratico e Love2D tem um repo interessante que promete _publish_ para tudo.  
Defold parece realmente perfeita para produção, já com anúncios e vários _publish_, aleḿ do google, poki não só recomenda como tem [parceria][parceria-link].

#### pygame pygbag
Consegui fazer um Dockerfile que funcione o pygame de dentro do container e usando [pygbag][pygbag-link] ele gerar a versão web. Obs:
- Dockerfile foi baseado em debian, com o ubuntu dava rolo com o pytnon3 do ubuntu e os pacotes via pip
- Para executar o container, além da boirlerplate conhecido de vídeo, precisou de um de aúdio e um extra de vídeo que parece ter a ver com a iGPU intel do laptop
- Para executar os jogos pygame puro, depende de com o jogo foi criado, se tem __init__.py, o que tem no main.py

#### Phaser
Ele é basicamente um arquivo .js e resto você é contigo, super simples. Acho que nem vale fazer um container para o dev.  
Talvez justufique para fazer um possível build para android, com o tal [Capacitor][capacitor-link]

#### Love2D
Esse repo é super promissor, temos que ver se conseguiremos executar  
[bootstrap-love2d-project][bootstrap-love2d-link]

[parceria-link]: https://developers.poki.com/guide/web-game-engines
[pygbag-link]: https://pygame-web.github.io/wiki/pygbag/
[capacitor-link]: https://phaser.io/tutorials/bring-your-phaser-game-to-ios-and-android-with-capacitor
[bootstrap-love2d-link]: https://github.com/Oval-Tutu/bootstrap-love2d-project


## 2023

### 18/out

Flertando com outras ga**me engines/frameworks**, em particular essas duas, ambas usam **Lua**:
- **Defold**, por estar no site do android dev
- **Solar2D** (ex Corona) por parecer ser possível exportar

Temos os seguintes vetos: Unity, Unreal e Godot... se for para aprender uma Engine, que seja Godot
E não estamos muito animados de aprender C++ (chuta logo o balde e aprende uma Godot com _GDScript_), já C# parece legal.

Ainda precisamos verificar como exportar para android Pygame-CE e talvez MonoGame para saber se já as descartamos ou não

### 13/out

Não vai nem a pau gerar o apk, ou melhor, gerar o apk funciona, ele só não instala sem acusar nenhum erro.  
Já tentamos várias imagens de sdk/ndk
- inspiração: https://github.com/Thecoolpeople/love-android-docker
- fonte: https://github.com/richardtin/docker-android-sdk
- 
E vamos olhar novamente as opções de game engines/framewoks, contanto que não seja java, se possível não c++, e o mais importante  
que seja fácil **exportar para android**

### 09/out

Tentando baixar o Android SDK e NDK sem o Android Studio está bem confuso. E até agora não achei nenhum guia específico de Linux->Android.  
E os arquivos ficam bem grandes.
- love-android 265M vs 326M
- SDK API 31 255M Android 12
- NDK r21d 1.1GB
  

### 08/out

**Gerar o AppImag**e de dentro do **container** também **não** está rolando sem ideias. Vamos abandonar containers para o Love2D.  
Não será problema de mantaer, afinal, tanto o Love2D como appimagetool rodam de AppImage.  
E ainda falta o principal, o apk/aab
E o pygame-ce.. e talvez MonoGame


### 07/out

Tchau container para **executar Love2D**, já precisamos fazer umas configurações avançadas para rodar o jogo, mas sem audio.  
O **Audio parace ser muito mais enrolado**, rolo com libjack, pulsaudio, alsa...    
Para executar melhor usar direto o AppImage.

Já para fazer os **builds** em Linux, Windows e Web, talvez ainda use o container, mas só se conseguir fazer o **apk/aab de Android** lá dentro também.

### 06/out

Container com `ubuntu:22.04` precisando instalar o npm ficou com **314MB** vs `node:20.8-bookworm-slim` (debian) com **305MB**.  
Vamos manter a do ubuntu.

Precisamos do npm para o lovejs e libfuse2 para o AppImage do Love2D. Jogos simples rodam, mas sem áudio. É rolo de SDL e jack/alsa/pulse.  
Talvez deixe o container apenas para _build_ (se funcionar, claro), porque colocar essa bibliotecas para execução aumentam consideravelmente o tamanho do container.

### 05/out

#### Pygame

Deu trabalho criar o _"executável"_ usando o **pyinstaller**. Teve rolo da importação das figuras, tive que usar o caminho relativo.  
E o jogo .exe precisa ficar no mesmo que nível que as pastas de assets

Tentei rapidamente o tal **nuitka**, mas sem sucesso

#### Monogame

Monogame está um saco de instalar **dentro do container** (estamos usando [podman](https://podman.io/)). Não fica claro quais são as bibliotecas necessárias, conseguimos fazer a tela azul abrir, mas o tal **mgcb-editor** não rodou nem a pau.  
Fora do container, no Mint o mgcb-editor chegou a abrir, meio bugado, mas abril

      
#### Love2D
Show de bola, roda de boa no Linux, super fácil gerar o **AppImage**. A versão web conseguimos com o [love.js](https://github.com/Davidobot/love.js), mas só ocnseguir executar usando a sugestão de criar um **servidor pelo python**. Sei que da para gerar um arquivo só, ou pelo menos um **html clicável** porque pelo [LÖVE Web Builder - Package Your Game](https://schellingb.github.io/LoveWebBuilder/package) funciona.
