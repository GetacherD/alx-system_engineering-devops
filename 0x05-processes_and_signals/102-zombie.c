#include <unistd.h>
#include <stdio.h>
#include <sys/stat.h>
#include <stdlib.h>
/**
 * infinite_while - dummy infinite loop
 * Return: 0 always
 */
int infinite_while(void)
{
	while (1)
	{
		sleep(1);
	}
	return (0);
}
/**
 * main - entry point
 * Return: 0 always
 */
int main(void)
{
	pid_t pid;
	int i;

	for (i = 0; i < 5; i++)
	{
		pid = fork();
		if (pid == 0)
			exit(0);
		else
			printf("Zombie process created, PID: %d\n", getpid());
	}
	infinite_while();
	return (0);
}
