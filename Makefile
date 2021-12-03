all: # 构建
	make tar 
windows:
	CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build -ldflags "-s -w" -o windows_amd64.exe main.go
mac:
	CGO_ENABLED=1 GOOS=darwin GOARCH=amd64 go build -ldflags "-s -w" -o macos_amd64 main.go
mac_arm:
	CGO_ENABLED=1 GOOS=darwin GOARCH=arm64 go build -ldflags "-s -w" -o macos_arm64 main.go
linux:
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags "-s -w" -o linux_amd64 main.go
tar: # 打包
	CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build -o windows_amd64.exe main.go
	CGO_ENABLED=1 GOOS=darwin GOARCH=amd64 go build -o macos_amd64 main.go
	CGO_ENABLED=1 GOOS=darwin GOARCH=arm64 go build -o macos_arm64 main.go
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o linux_amd64 main.go
	tar czvf go_orm_tools.zip linux_amd64 windows_amd64.exe macos_amd64 macos_arm64 config.yml

tar1: # 打包
	CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build -o windows_amd64.exe main.go
	tar czvf gormt_windows.zip windows_amd64.exe config.yml
	CGO_ENABLED=1 GOOS=darwin GOARCH=amd64 go build -o macos_amd64 main.go
	tar czvf gormt_mac.zip macos_amd64 config.yml
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o linux_amd64 main.go
	tar czvf gormt_linux.zip linux_amd64 config.yml

clear:
	test ! -d model/ || rm -rf  model/*
	test ! -d err/ || rm -rf  err/
	test ! -f gormt || rm gormt
	test ! -f gormt.exe || rm gormt.exe
	test ! -f gormt_linux.zip || rm gormt_linux.zip
	test ! -f gormt_mac.zip || rm gormt_mac.zip
	test ! -f gormt_windows.zip || rm gormt_windows.zip
	test ! -f windows_amd64.exe || rm windows_amd64.exe
	test ! -f macos_amd64 || rm macos_amd64
	test ! -f macos_arm64 || rm macos_arm64
	test ! -f linux_amd64 || rm linux_amd64
	test ! -f go_orm_tools.zip || rm go_orm_tools.zip


	