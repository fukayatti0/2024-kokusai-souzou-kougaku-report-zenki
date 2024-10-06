import subprocess
import re
import csv
from datetime import datetime
import os
from typing import Dict, Tuple, List

def run_command(command: str) -> Tuple[str, bool]:
    try:
        result = subprocess.run(command.split(), capture_output=True, text=True)
        output = result.stdout + result.stderr
        return output, True
    except FileNotFoundError:
        return f"コマンドが見つかりません: {command}", False
    except subprocess.SubprocessError as e:
        return f"コマンド実行エラー: {e}", False

def get_versions() -> List[Dict[str, str]]:
    commands = {
        'Python': {
            'cmd': 'python -V',
            'pattern': r'Python (\d+\.\d+\.\d+)'
        },
        'Ruby': {
            'cmd': 'ruby --version',
            'pattern': r'ruby (\d+\.\d+\.\d+)'
        },
        'Node.js': {
            'cmd': 'node -v',
            'pattern': r'v(\d+\.\d+\.\d+)'
        },
        'Go': {
            'cmd': 'go version',
            'pattern': r'go version go(\d+\.\d+(\.\d+)?)'
        },
        'Java': {
            'cmd': 'java --version',
            'pattern': r'openjdk (\d+\.\d+\.\d+)'
        },
        'GCC': {
            'cmd': 'gcc --version',
            'pattern': r'gcc.+?(\d+\.\d+\.\d+)'
        },
        'G++': {
            'cmd': 'g++ --version',
            'pattern': r'g\+\+.+?(\d+\.\d+\.\d+)'
        },
        'Swift': {
            'cmd': 'swift --version',
            'pattern': r'Swift version (\d+\.\d+(\.\d+)?)'
        },
        'NASM': {
            'cmd': 'nasm -v',
            'pattern': r'NASM version (\d+\.\d+(\.\d+)?)'
        },
        'MCS': {
            'cmd': 'mcs --version',
            'pattern': r'Mono C# compiler version (\d+\.\d+(\.\d+)?)'
        }

    }

    versions = []
    
    for lang, info in commands.items():
        output, success = run_command(info['cmd'])
        version_data = {
            'プログラミング言語': lang,
            'バージョン': '',
            'コマンド': info['cmd'],
            '詳細出力': '',
            '確認日時': datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        }
        
        if success:
            match = re.search(info['pattern'], output)
            if match:
                version_data['バージョン'] = match.group(1)
            else:
                version_data['バージョン'] = 'バージョン解析失敗'
            version_data['詳細出力'] = output.strip().replace('\n', ' ')
        else:
            version_data['詳細出力'] = output
        
        versions.append(version_data)
    
    return versions

def save_to_csv(data: List[Dict[str, str]], filename: str):
    headers = ['プログラミング言語', 'バージョン', 'コマンド', '詳細出力', '確認日時']
    
    with open(filename, 'w', newline='', encoding='utf-8-sig') as f:
        writer = csv.DictWriter(f, fieldnames=headers)
        writer.writeheader()
        writer.writerows(data)

def main():
    print("各プログラミング言語のバージョンを確認中...")
    versions = get_versions()
    
    # CSVファイル名を現在の日時で生成
    filename = f'program_versions_{datetime.now().strftime("%Y%m%d_%H%M%S")}.csv'
    
    save_to_csv(versions, filename)
    
    print(f"\nバージョン情報をCSVファイルに保存しました: {filename}")
    print("\n概要:")
    for v in versions:
        print(f"{v['プログラミング言語']}: {v['バージョン']}")

if __name__ == "__main__":
    main()
