package service

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestAdd(t *testing.T) {
	result := Add(8, 3)
	expected := 5

	assert.Equal(t, expected, result)
}
