#!/usr/bin/env python3

import argparse
from subprocess import run as sp_run
import sys
from pathlib import Path


# --- CONFIGURAÇÕES GLOBAIS ---
PODRUN_SCRIPT = Path("~/podrun.sh").expanduser().as_posix()
IMAGE_NAME = "bfg:latest" # Renomeado para bfg:latest


def run_command(command_parts):
    """Função auxiliar para executar o comando completo"""
    full_command = [PODRUN_SCRIPT] + command_parts
    print(f"Executando: {' '.join(full_command)}")
    sp_run(full_command)


def setup_argument_parser():
    
    parser = argparse.ArgumentParser(
        description="Ferramenta CLI para gerenciar e executar projetos de jogos (Pygame, Love2D) usando podrun.sh",
        formatter_class=argparse.RawTextHelpFormatter
    )

    # Grupo de argumentos mutuamente exclusivos, o usuário deve escolher apenas um comando.
    group = parser.add_mutually_exclusive_group(required=True)

    # --- COMANDOS PYGAME / PYTHON ---

    group.add_argument(
        '--glow',
        action='store_const',
        const='glow',
        dest='command',
        help='Executa o módulo "teste_glow" no container (Pygame/Python)'
    )
    
    group.add_argument(
        '--build-py', # Renomeado
        action='store_const',
        const='build-py',
        dest='command',
        help='Constrói o projeto FlapPyBird com pygbag (Pygame)'
    )

    group.add_argument(
        '--serve-py', # Renomeado
        action='store_const',
        const='serve-py',
        dest='command',
        help='Inicia um servidor HTTP para servir FlapPyBird/web na porta 8000 (Python)'
    )

    group.add_argument(
        '--aliens',
        action='store_const',
        const='aliens',
        dest='command',
        help='Executa o exemplo "aliens" do Pygame'
    )

    # --- COMANDOS LOVE2D / LUA ---

    group.add_argument(
        '--build-love',
        action='store_const',
        const='build-love',
        dest='command',
        help='Constrói o projeto love2d-flappy-bird usando love.js'
    )

    group.add_argument(
        '--serve-love',
        action='store_const',
        const='serve-love',
        dest='command',
        help='Inicia um servidor HTTP para servir o build Love2D na porta 8000'
    )

    # --- REMAINDER ---

    # Captura todos os argumentos restantes para o podman
    parser.add_argument(
        'extra_args',
        nargs=argparse.REMAINDER,
        default=[],
        help='Argumentos adicionais a serem passados diretamente para o podrun.sh (e podman)'
    )
    
    return parser


def get_execution_command(args):

    podrun_args = args.extra_args

    command = []

    if args.command == 'glow':
        command = ['-w', '/app', IMAGE_NAME, 'python', '-m', 'teste_glow']

    elif args.command == 'build-py':
        command = [IMAGE_NAME, 'pygbag', '--build', '/app/FlapPyBird']
        
    elif args.command == 'serve-py':
        command = ['-p', '8000:8000', IMAGE_NAME, 'python', '-m', 'http.server', '--directory', '/app/FlapPyBird/build/web']
        
    elif args.command == 'aliens':
        command = [IMAGE_NAME, 'python', '-m', 'pygame.examples.aliens']

    elif args.command == 'build-love':
        command = ['-w', '/app', IMAGE_NAME, 'love.js', '-t', 'flap', '-c', '/app/love2d-flappy-bird', '/app/buildado']

    elif args.command == 'serve-love':
        command = ['-p', '8000:8000', IMAGE_NAME, 'python', '-m', 'http.server', '--directory', '/app/buildado']

    # Adiciona os argumentos extras do podman no início
    return podrun_args + command


if __name__ == '__main__':
    # Garante que a saída (incluindo help e erros do argparse) use UTF-8
    sys.stdout.reconfigure(encoding='utf-8')
    sys.stderr.reconfigure(encoding='utf-8')

    cli_parser = setup_argument_parser()

    args = cli_parser.parse_args()

    execution_command = get_execution_command(args)

    run_command(execution_command)
