# Script para atualizar os boletos no GitHub
# Roda sempre que tiver arquivos novos na pasta "download claude cowork"

$origem = "C:\Users\Thay_\Downloads\download claude cowork"
$repo = "C:\Users\Thay_\Desktop\meu amor hehehe\claude cowork\boletos-mercadinho-repo"

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "Atualizando boletos - $(Get-Date -Format 'dd/MM/yyyy HH:mm')" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

Set-Location $repo

# Atualiza o repositorio local primeiro
git pull

# Copia os arquivos mais recentes da pasta de downloads
$arquivos = @("boletos mo1.xls", "boletos mo2.xls", "boletos mo4.xls", "boletos mo 2.xls")
$copiados = @()

foreach ($nome in $arquivos) {
    $caminhoOrigem = Join-Path $origem $nome
    if (Test-Path $caminhoOrigem) {
        $destino = $nome -replace " mo 2", " mo2"
        Copy-Item $caminhoOrigem (Join-Path $repo $destino) -Force
        $copiados += $destino
        Write-Host "Copiado: $destino" -ForegroundColor Green
    }
}

if ($copiados.Count -eq 0) {
    Write-Host "Nenhum arquivo boleto encontrado em: $origem" -ForegroundColor Yellow
    Read-Host "Pressione Enter para fechar"
    exit
}

# Verifica se tem alteracao
git add "boletos mo1.xls" "boletos mo2.xls" "boletos mo4.xls" 2>$null
$status = git status --porcelain

if ($status) {
    $data = Get-Date -Format "dd/MM/yyyy"
    git commit -m "Atualizacao de boletos - $data"
    git push
    Write-Host ""
    Write-Host "Boletos enviados com sucesso para o GitHub!" -ForegroundColor Green
    Write-Host "A analise sera gerada automaticamente na proxima execucao agendada." -ForegroundColor Green
} else {
    Write-Host ""
    Write-Host "Nenhuma alteracao detectada (arquivos iguais aos ja enviados)." -ForegroundColor Yellow
}

Write-Host ""
Read-Host "Pressione Enter para fechar"
