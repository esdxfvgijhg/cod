#!/usr/bin/python
import argparse
import gym


def build_arg_parser():
    parser = argparse.ArgumentParser(description="Run an environment")
    parser.add_argument("--input-env", dest="input_env", required=True, choices=["cartpole", "mountaincar", "pendulum"], help="Specify the name of the environment")
    return parser


if __name__ == "__main__":
    args = build_arg_parser().parse_args()
    input_env = args.input_env
    name_map = {"cartpole": "CartPole-v0", "mountaincar": "MountainCar-v0", "pendulum": "Pendulum-v0"}
    env = gym.make(name_map[input_env])  # Create the environment
    for _ in range(20):  # Start iterating
        observation = env.reset()  # Reset the environment
        for i in range(100):  # Iterate 100 times
            env.render()  # Render the environment
            print(observation)  # Print the current observation
            action = env.action_space.sample()  # Take action
            observation, reward, done, info = env.step(action)  # other info based on the action taken # Extract the observation, reward, status and
            if done:  # Check if it's done
                print("Episode finished after {} timesteps".format(i + 1))
                break
