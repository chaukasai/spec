module github.com/chaukasai/spec

go 1.21

require (
	google.golang.org/grpc v1.65.0
	google.golang.org/protobuf v1.34.1
)

// For development and CI before first release
// Remove this line after publishing the first version
replace github.com/chaukasai/spec => ./

require (
	golang.org/x/net v0.25.0 // indirect
	golang.org/x/sys v0.20.0 // indirect
	golang.org/x/text v0.15.0 // indirect
	google.golang.org/genproto/googleapis/rpc v0.0.0-20240528184218-531527333157 // indirect
)
