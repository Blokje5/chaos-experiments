package basic

import (
	"context"
	"encoding/json"
	"net/http"

	"github.com/go-kit/kit/endpoint"
	httptransport "github.com/go-kit/kit/transport/http"
)


type service struct {}

type response struct {
	Value string `json:"value"`
}

func (s *service) Response() (response, error) {
	return response{
		Value: "Hello, World!",
	}, nil
}

func makeEndpoint(svc *service) endpoint.Endpoint {
	return func(_ context.Context, _ interface{}) (interface{}, error) {

		v, err := svc.Response()
		if err != nil {
			return v, nil
		}
		return  v, nil
	}
}

func decodeRequest(_ context.Context, _ *http.Request) (interface{}, error) {
	return nil, nil
}

func encodeResponse(_ context.Context, w http.ResponseWriter, response interface{}) error {
	return json.NewEncoder(w).Encode(response)
}


func Start() error {
	svc := &service{}
	handler := httptransport.NewServer(
		makeEndpoint(svc),
		decodeRequest,
		encodeResponse,
	)

	http.Handle("/", handler)
	return http.ListenAndServe(":8080", nil)
}