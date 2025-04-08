package service

import (
	"testing"
)

func TestAdd(t *testing.T) {
	result := Add(8, 3)
	expected := 5

	if result != expected {
		t.Errorf("expected %d but got %d", expected, result)
	}
}
