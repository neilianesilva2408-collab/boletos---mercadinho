# Script para baixar as planilhas ja analisadas do GitHub para a pasta Downloads
# Roda depois que o agente na nuvem termina de processar (9h00)

$destino = "C:\Users\Thay_\Downloads\download claude cowork"
$repo = "C:\Users\Thay_\Desktop\meu amor hehehe\claude cowork\boletos-mercadinho-repo"

Set-Location $repo
git pull *> $null

$arquivos = @("boletos mo1.xlsx", "boletos mo2.xlsx", "boletos mo4.xlsx")

foreach ($nome in $arquivos) {
    $origem = Join-Path $repo $nome
    if (Test-Path $origem) {
        $nomeDestino = $nome -replace ".xlsx", " - analise.xlsx"
        Copy-Item $origem (Join-Path $destino $nomeDestino) -Force
    }
}
