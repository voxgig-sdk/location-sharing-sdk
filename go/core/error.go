package core

type LocationSharingError struct {
	IsLocationSharingError bool
	Sdk              string
	Code             string
	Msg              string
	Ctx              *Context
	Result           any
	Spec             any
}

func NewLocationSharingError(code string, msg string, ctx *Context) *LocationSharingError {
	return &LocationSharingError{
		IsLocationSharingError: true,
		Sdk:              "LocationSharing",
		Code:             code,
		Msg:              msg,
		Ctx:              ctx,
	}
}

func (e *LocationSharingError) Error() string {
	return e.Msg
}
