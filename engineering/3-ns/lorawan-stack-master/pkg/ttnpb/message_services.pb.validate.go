// Code generated by protoc-gen-fieldmask. DO NOT EDIT.

package ttnpb

import (
	"bytes"
	"errors"
	"fmt"
	"net"
	"net/mail"
	"net/url"
	"regexp"
	"strings"
	"time"
	"unicode/utf8"

	"github.com/gogo/protobuf/types"
)

// ensure the imports are used
var (
	_ = bytes.MinRead
	_ = errors.New("")
	_ = fmt.Print
	_ = utf8.UTFMax
	_ = (*regexp.Regexp)(nil)
	_ = (*strings.Reader)(nil)
	_ = net.IPv4len
	_ = time.Duration(0)
	_ = (*url.URL)(nil)
	_ = (*mail.Address)(nil)
	_ = types.DynamicAny{}
)

// define the regex for a UUID once up-front
var _message_services_uuidPattern = regexp.MustCompile("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")

// ValidateFields checks the field values on ProcessUplinkMessageRequest with
// the rules defined in the proto definition for this message. If any rules
// are violated, an error is returned.
func (m *ProcessUplinkMessageRequest) ValidateFields(paths ...string) error {
	if m == nil {
		return nil
	}

	if len(paths) == 0 {
		paths = ProcessUplinkMessageRequestFieldPathsNested
	}

	for name, subs := range _processPaths(append(paths[:0:0], paths...)) {
		_ = subs
		switch name {
		case "ids":

			if v, ok := interface{}(&m.EndDeviceIdentifiers).(interface{ ValidateFields(...string) error }); ok {
				if err := v.ValidateFields(subs...); err != nil {
					return ProcessUplinkMessageRequestValidationError{
						field:  "ids",
						reason: "embedded message failed validation",
						cause:  err,
					}
				}
			}

		case "end_device_version_ids":

			if v, ok := interface{}(&m.EndDeviceVersionIDs).(interface{ ValidateFields(...string) error }); ok {
				if err := v.ValidateFields(subs...); err != nil {
					return ProcessUplinkMessageRequestValidationError{
						field:  "end_device_version_ids",
						reason: "embedded message failed validation",
						cause:  err,
					}
				}
			}

		case "message":

			if v, ok := interface{}(&m.Message).(interface{ ValidateFields(...string) error }); ok {
				if err := v.ValidateFields(subs...); err != nil {
					return ProcessUplinkMessageRequestValidationError{
						field:  "message",
						reason: "embedded message failed validation",
						cause:  err,
					}
				}
			}

		case "parameter":
			// no validation rules for Parameter
		default:
			return ProcessUplinkMessageRequestValidationError{
				field:  name,
				reason: "invalid field path",
			}
		}
	}
	return nil
}

// ProcessUplinkMessageRequestValidationError is the validation error returned
// by ProcessUplinkMessageRequest.ValidateFields if the designated constraints
// aren't met.
type ProcessUplinkMessageRequestValidationError struct {
	field  string
	reason string
	cause  error
	key    bool
}

// Field function returns field value.
func (e ProcessUplinkMessageRequestValidationError) Field() string { return e.field }

// Reason function returns reason value.
func (e ProcessUplinkMessageRequestValidationError) Reason() string { return e.reason }

// Cause function returns cause value.
func (e ProcessUplinkMessageRequestValidationError) Cause() error { return e.cause }

// Key function returns key value.
func (e ProcessUplinkMessageRequestValidationError) Key() bool { return e.key }

// ErrorName returns error name.
func (e ProcessUplinkMessageRequestValidationError) ErrorName() string {
	return "ProcessUplinkMessageRequestValidationError"
}

// Error satisfies the builtin error interface
func (e ProcessUplinkMessageRequestValidationError) Error() string {
	cause := ""
	if e.cause != nil {
		cause = fmt.Sprintf(" | caused by: %v", e.cause)
	}

	key := ""
	if e.key {
		key = "key for "
	}

	return fmt.Sprintf(
		"invalid %sProcessUplinkMessageRequest.%s: %s%s",
		key,
		e.field,
		e.reason,
		cause)
}

var _ error = ProcessUplinkMessageRequestValidationError{}

var _ interface {
	Field() string
	Reason() string
	Key() bool
	Cause() error
	ErrorName() string
} = ProcessUplinkMessageRequestValidationError{}

// ValidateFields checks the field values on ProcessDownlinkMessageRequest with
// the rules defined in the proto definition for this message. If any rules
// are violated, an error is returned.
func (m *ProcessDownlinkMessageRequest) ValidateFields(paths ...string) error {
	if m == nil {
		return nil
	}

	if len(paths) == 0 {
		paths = ProcessDownlinkMessageRequestFieldPathsNested
	}

	for name, subs := range _processPaths(append(paths[:0:0], paths...)) {
		_ = subs
		switch name {
		case "ids":

			if v, ok := interface{}(&m.EndDeviceIdentifiers).(interface{ ValidateFields(...string) error }); ok {
				if err := v.ValidateFields(subs...); err != nil {
					return ProcessDownlinkMessageRequestValidationError{
						field:  "ids",
						reason: "embedded message failed validation",
						cause:  err,
					}
				}
			}

		case "end_device_version_ids":

			if v, ok := interface{}(&m.EndDeviceVersionIDs).(interface{ ValidateFields(...string) error }); ok {
				if err := v.ValidateFields(subs...); err != nil {
					return ProcessDownlinkMessageRequestValidationError{
						field:  "end_device_version_ids",
						reason: "embedded message failed validation",
						cause:  err,
					}
				}
			}

		case "message":

			if v, ok := interface{}(&m.Message).(interface{ ValidateFields(...string) error }); ok {
				if err := v.ValidateFields(subs...); err != nil {
					return ProcessDownlinkMessageRequestValidationError{
						field:  "message",
						reason: "embedded message failed validation",
						cause:  err,
					}
				}
			}

		case "parameter":
			// no validation rules for Parameter
		default:
			return ProcessDownlinkMessageRequestValidationError{
				field:  name,
				reason: "invalid field path",
			}
		}
	}
	return nil
}

// ProcessDownlinkMessageRequestValidationError is the validation error
// returned by ProcessDownlinkMessageRequest.ValidateFields if the designated
// constraints aren't met.
type ProcessDownlinkMessageRequestValidationError struct {
	field  string
	reason string
	cause  error
	key    bool
}

// Field function returns field value.
func (e ProcessDownlinkMessageRequestValidationError) Field() string { return e.field }

// Reason function returns reason value.
func (e ProcessDownlinkMessageRequestValidationError) Reason() string { return e.reason }

// Cause function returns cause value.
func (e ProcessDownlinkMessageRequestValidationError) Cause() error { return e.cause }

// Key function returns key value.
func (e ProcessDownlinkMessageRequestValidationError) Key() bool { return e.key }

// ErrorName returns error name.
func (e ProcessDownlinkMessageRequestValidationError) ErrorName() string {
	return "ProcessDownlinkMessageRequestValidationError"
}

// Error satisfies the builtin error interface
func (e ProcessDownlinkMessageRequestValidationError) Error() string {
	cause := ""
	if e.cause != nil {
		cause = fmt.Sprintf(" | caused by: %v", e.cause)
	}

	key := ""
	if e.key {
		key = "key for "
	}

	return fmt.Sprintf(
		"invalid %sProcessDownlinkMessageRequest.%s: %s%s",
		key,
		e.field,
		e.reason,
		cause)
}

var _ error = ProcessDownlinkMessageRequestValidationError{}

var _ interface {
	Field() string
	Reason() string
	Key() bool
	Cause() error
	ErrorName() string
} = ProcessDownlinkMessageRequestValidationError{}
